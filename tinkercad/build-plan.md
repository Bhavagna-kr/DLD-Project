# Tinkercad Circuits Build Plan

## Goal
Create a gate-level simulation of the separate three-load combinational allocator. The full five-load FPGA architecture remains documented under `fpga/` and is not automatically replaced by this simplified physical model.

## Three-load specification
- L1 demand 5, highest priority
- L2 demand 4, medium priority
- L3 demand 3, lowest priority
- Available power `P[3:0]` (0–15)
- Requests `R1`, `R2`, `R3`
- Outputs `A1`, `A2`, `A3`

## Tinkercad implementation checklist
1. Add a 4-bit binary input arrangement for `P[3:0]` and three request switches.
2. Implement threshold terms T3, T4, T5, T7, T8, T9, and T12 using AND/OR/NOT gates.
3. Implement the accepted-load equations from `docs/logic-design.md`.
4. Connect each accepted output to an LED indicator through a series resistor (or use a suitable driver stage).
5. Test all 128 input combinations using a truth table/reference results.
6. Capture screenshots and add the Tinkercad share URL here after validation.

## Status
Not yet built. This is a plan only; do not treat it as a finished simulation.
