"""Pin-level netlist for the three-load priority allocator (Tinkercad build).

Single source of truth for the wiring tables in tinkercad/wiring-guide.md.
Run:  python3 tinkercad/netlist.py   -> exhaustive 128-case check + wiring tables

Minimised equations (2-input gates only):
  T4  = P3 + P2                      T3  = T4 + P1P0
  T5  = P3 + P2(P1+P0)               T7  = P3 + P2(P1P0)
  T9  = P3(P2+P1+P0)                 T12 = P3P2          (T8 = P3)
  A1  = R1 . T5
  A2  = R2 . (T9 + A1'.T4)
  A3  = R3 . (T12 + A2'.P3 + A1'.(T7 + A2'.T3))
"""

# 14-pin quad 2-input gate pinout (74HC08 / 74HC32): (inA, inB, out)
QUAD = [(1, 2, 3), (4, 5, 6), (9, 10, 8), (12, 13, 11)]
# 74HC04 hex inverter: (in, out)
HEX = [(1, 2), (3, 4), (5, 6), (9, 8), (11, 10), (13, 12)]

CHIPS = {
    "U1": "74HC32", "U2": "74HC08", "U3": "74HC32", "U4": "74HC08",
    "U5": "74HC04", "U6": "74HC08", "U7": "74HC32",
}

# (chip, gate#, inputs, output-net)   gate# is 1-based
GATES = [
    ("U2", 1, ("P1", "P0"), "P1.P0"),
    ("U1", 1, ("P3", "P2"), "T4"),
    ("U1", 2, ("P1", "P0"), "P1+P0"),
    ("U1", 3, ("P2", "P1+P0"), "P2+P1+P0"),
    ("U1", 4, ("T4", "P1.P0"), "T3"),
    ("U2", 2, ("P2", "P1+P0"), "P2.(P1+P0)"),
    ("U2", 3, ("P2", "P1.P0"), "P2.P1.P0"),
    ("U2", 4, ("P3", "P2+P1+P0"), "T9"),
    ("U3", 1, ("P3", "P2.(P1+P0)"), "T5"),
    ("U3", 2, ("P3", "P2.P1.P0"), "T7"),
    ("U4", 1, ("P3", "P2"), "T12"),
    ("U4", 2, ("R1", "T5"), "A1"),
    ("U5", 1, ("A1",), "A1'"),
    ("U4", 3, ("A1'", "T4"), "A1'.T4"),
    ("U3", 3, ("T9", "A1'.T4"), "A2sel"),
    ("U4", 4, ("R2", "A2sel"), "A2"),
    ("U5", 2, ("A2",), "A2'"),
    ("U6", 1, ("A2'", "P3"), "A2'.P3"),
    ("U6", 2, ("A2'", "T3"), "A2'.T3"),
    ("U7", 1, ("T7", "A2'.T3"), "Y"),
    ("U6", 3, ("A1'", "Y"), "A1'.Y"),
    ("U3", 4, ("T12", "A2'.P3"), "X"),
    ("U7", 2, ("X", "A1'.Y"), "A3sel"),
    ("U6", 4, ("R3", "A3sel"), "A3"),
]

# Unused gate inputs on CMOS must be tied to a defined level (GND).
SPARE_INPUTS = {"U5": [5, 9, 11, 13], "U7": [9, 10, 12, 13]}

INPUTS = ["P3", "P2", "P1", "P0", "R1", "R2", "R3"]
OUTPUTS = ["A1", "A2", "A3"]


def evaluate(inp):
    v = dict(inp)
    for chip, _, ins, out in GATES:  # GATES is in topological order
        kind = CHIPS[chip]
        a = [v[n] for n in ins]
        v[out] = {"74HC08": lambda: a[0] & a[1],
                  "74HC32": lambda: a[0] | a[1],
                  "74HC04": lambda: 1 - a[0]}[kind]()
    return v


def greedy(p, r1, r2, r3):
    rem, out = p, []
    for req, d in ((r1, 5), (r2, 4), (r3, 3)):
        ok = int(req and rem >= d)
        rem -= d * ok
        out.append(ok)
    return out


def pin_of(chip, gate, idx):
    """idx 0/1 = input A/B, 2 = output."""
    if CHIPS[chip] == "74HC04":
        i, o = HEX[gate - 1]
        return o if idx == 2 else i
    return QUAD[gate - 1][idx]


def check():
    # sanity: no gate slot used twice
    slots = [(c, g) for c, g, _, _ in GATES]
    assert len(slots) == len(set(slots)), "gate slot reused"
    for p in range(16):
        for r in range(8):
            r1, r2, r3 = (r >> 2) & 1, (r >> 1) & 1, r & 1
            inp = {"P3": p >> 3 & 1, "P2": p >> 2 & 1, "P1": p >> 1 & 1,
                   "P0": p & 1, "R1": r1, "R2": r2, "R3": r3}
            v = evaluate(inp)
            got = [v["A1"], v["A2"], v["A3"]]
            assert got == greedy(p, r1, r2, r3), (p, r1, r2, r3, got)
    return 128


def net_table():
    """net -> (driver, [loads]) with chip pins."""
    nets = {}
    for n in INPUTS:
        nets[n] = [f"switch {n}", []]
    for chip, g, ins, out in GATES:
        nets.setdefault(out, [None, []])[0] = f"{chip}-{pin_of(chip, g, 2)}"
        for k, n in enumerate(ins):
            nets[n][1].append(f"{chip}-{pin_of(chip, g, k)}")
    for n in OUTPUTS:
        nets[n][1].append(f"LED {n} (via 330 ohm)")
    return nets


if __name__ == "__main__":
    print(f"Exhaustive check passed: {check()}/128 cases match greedy model\n")
    for net, (drv, loads) in net_table().items():
        print(f"{net:12s} {drv:10s} -> {', '.join(loads)}")
