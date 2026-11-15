# Logic Design

## A. Three-load combinational allocator (`rtl/`)

Load demands: L1=5, L2=4, L3=3. Priority: L1 > L2 > L3. Available power is unsigned `P[3:0]`.

Threshold predicates:

```text
T3  = P >= 3
T4  = P >= 4
T5  = P >= 5
T7  = P >= 7
T8  = P >= 8
T9  = P >= 9
T12 = P >= 12
```

Boolean forms:

```text
T3  = P3 OR P2 OR (P1 AND P0)
T4  = P3 OR P2
T5  = P3 OR [P2 AND (P1 OR P0)]
T7  = P3 OR (P2 AND P1 AND P0)
T8  = P3
T9  = P3 AND (P2 OR P1 OR P0)
T12 = P3 AND P2
```

Accepted outputs:

```text
A1 = R1 AND T5
A2 = R2 AND ((A1 AND T9) OR (NOT A1 AND T4))
A3 = R3 AND ((A1 AND A2 AND T12)
          OR (A1 AND NOT A2 AND T8)
          OR (NOT A1 AND A2 AND T7)
          OR (NOT A1 AND NOT A2 AND T3))
```

The equations use the accepted state of higher-priority loads to determine how much capacity remains for the next request.

## B. Original FPGA architecture (`fpga/`)

The original FPGA controller has five loads with demands 5, 4, 3, 4, and 2. Available power is 5 bits (0–31). Its priority controller uses procedural combinational logic to subtract each accepted load's demand from `remaining_power`. The load FSM changes one load at a time: it sheds lower-priority loads first and restores higher-priority loads first.

Refer to source modules in `fpga/src/priority_controller.v`, `fpga/src/load_fsm.v`, and `fpga/src/top_module.v`.

## Important distinction
The three-load threshold equations and the five-load FPGA source are two different models. Do not describe one as a direct one-to-one translation of the other.
