"""Draw a net-labelled gate schematic from netlist.py -> tinkercad/schematic.png"""
import os
import sys

import schemdraw
import schemdraw.elements as elm
import schemdraw.logic as logic

sys.path.insert(0, os.path.dirname(__file__))
from netlist import CHIPS, GATES, INPUTS, pin_of  # noqa: E402

STAGES = [
    ("Stage 1 - power thresholds", {"P1.P0", "T4", "P1+P0", "P2+P1+P0", "T3",
                                    "P2.(P1+P0)", "P2.P1.P0", "T9", "T5", "T7", "T12"}),
    ("Stage 2 - load 1 and load 2", {"A1", "A1'", "A1'.T4", "A2sel", "A2"}),
    ("Stage 3 - load 3", {"A2'", "A2'.P3", "A2'.T3", "Y", "A1'.Y", "X", "A3sel", "A3"}),
]
NCOL = 4

COLW, ROWH = 5.6, 2.4
with schemdraw.Drawing(file=os.path.join(os.path.dirname(__file__), "schematic.png"),
                       show=False, dpi=160) as d:
    d.config(fontsize=9, unit=0.9)
    top = 0.0
    for title, nets in STAGES:
        gates = [gt for gt in GATES if gt[3] in nets]
        d.add(elm.Label().at((-1.5, top)).label(title, fontsize=11, halign="left",
                                                color="#444444"))
        for i, (chip, g, ins, out) in enumerate(gates):
            x, y = (i % NCOL) * COLW, top - 1.4 - (i // NCOL) * ROWH
            kind = CHIPS[chip]
            if kind == "74HC04":
                el = logic.Not().at((x, y)).anchor("in1")
                d.add(el)
                d.add(elm.Line().left(0.4).at(el.in1).label(
                    f"{ins[0]} [{pin_of(chip, g, 0)}]", loc="left", fontsize=8))
            else:
                G = logic.And if kind == "74HC08" else logic.Or
                el = G(inputs=2).at((x, y)).anchor("in1")
                d.add(el)
                for k, pin in enumerate((el.in1, el.in2)):
                    d.add(elm.Line().left(0.4).at(pin).label(
                        f"{ins[k]} [{pin_of(chip, g, k)}]", loc="left", fontsize=8))
            d.add(elm.Line().right(0.4).at(el.out).label(
                f"[{pin_of(chip, g, 2)}] {out}", loc="right", fontsize=8,
                color="#b00020" if out in ("A1", "A2", "A3") else "black"))
            d.add(elm.Label().at(((el.in1[0] + el.out[0]) / 2, y + 0.6)).label(
                f"{chip}-G{g} {kind}", fontsize=7, color="#1a5fb4"))
            last = y
        top = last - 2.2
    d.add(elm.Label().at((-1.5, 1.4)).label(
        "Three-load priority allocator - gate wiring  (net name [chip pin]).  "
        "All chips: pin 14 = +5 V, pin 7 = GND", fontsize=10, halign="left"))
