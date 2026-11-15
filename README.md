# Priority-Based Power Load Controller

A Digital Logic Design project for allocating limited available power to three loads according to fixed priority.

## Project status

- **Original FPGA design:** The project was previously implemented in FPGA logic.
- **Physical breadboard prototype:** Not completed reliably. During troubleshooting, the request/power input rows measured approximately 0 V, so end-to-end operation could not be demonstrated.
- **Tinkercad implementation:** Planned as the next step. The circuit must be built and tested in Tinkercad before screenshots or a simulation link are added here.

## Original system specification

| Load | Demand | Priority |
|---|---:|---|
| L1 | 5 units | Highest |
| L2 | 4 units | Medium |
| L3 | 3 units | Lowest |

Available power is a four-bit unsigned value:

\[
P = 8P_3 + 4P_2 + 2P_1 + P_0
\]

`R1`, `R2`, and `R3` are load requests. `A1`, `A2`, and `A3` indicate accepted loads. The controller scans L1, L2, then L3. A load is accepted only if its full demand fits in the remaining power. An unserved higher-priority request is skipped; lower-priority requests are still considered.

## Original Boolean specification

Threshold signals:

```text
T3  = (P >= 3)
T4  = (P >= 4)
T5  = (P >= 5)
T7  = (P >= 7)
T8  = (P >= 8)
T9  = (P >= 9)
T12 = (P >= 12)
```

Threshold Boolean forms:

```text
T3  = P3 OR P2 OR (P1 AND P0)
T4  = P3 OR P2
T5  = P3 OR [P2 AND (P1 OR P0)]
T7  = P3 OR (P2 AND P1 AND P0)
T8  = P3
T9  = P3 AND (P2 OR P1 OR P0)
T12 = P3 AND P2
```

Accepted-load outputs:

```text
A1 = R1 AND T5
A2 = R2 AND ((A1 AND T9) OR (NOT A1 AND T4))
A3 = R3 AND ((A1 AND A2 AND T12)
          OR (A1 AND NOT A2 AND T8)
          OR (NOT A1 AND A2 AND T7)
          OR (NOT A1 AND NOT A2 AND T3))
```

These equations encode the original greedy allocation policy. They are also implemented in `rtl/priority_load_controller.v` and checked by the included testbench.

## Repository contents

```text
DLD-Project/
├── README.md
├── docs/
│   ├── project-overview.md
│   ├── logic-design.md
│   ├── components.md
│   └── test-plan.md
├── rtl/
│   ├── priority_load_controller.v
│   └── tb_priority_load_controller.v
├── simulation/
│   └── run_tests.sh
├── tinkercad/
│   └── build-plan.md
└── images/
    └── .gitkeep
```

## Tinkercad plan

The next milestone is to reproduce the gate-level logic in Tinkercad Circuits, verify representative cases, and add the actual circuit share URL and screenshots. No Tinkercad circuit is claimed to exist until it has been built and checked.

## Verification

The Verilog testbench checks all 128 input combinations (16 possible power values × 8 request combinations). Run it with Icarus Verilog:

```bash
cd simulation
./run_tests.sh
```

See `docs/logic-design.md` for the allocation reasoning and `docs/test-plan.md` for directed examples.
