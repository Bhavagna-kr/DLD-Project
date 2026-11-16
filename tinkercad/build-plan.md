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
**Built and tested in Tinkercad Circuits (16 Nov 2026).**

- Tinkercad design: https://www.tinkercad.com/things/4uLk8jznWWk-fantabulous-vihelmo
- Wiring follows `wiring-guide.md` (3×74HC08, 3×74HC32, 1×74HC04); gate schematic in `schematic.png`.
- The netlist in `netlist.py` passes all 128 input cases in software; in the simulator, the three staged checkpoints and the 10-row final test table all matched.

As-built differences from the guide:
- Inputs use SPDT slide switches (one side to +5 V, other to GND, middle pin = signal), so no pull-down resistors are needed.
- The switches are powered by a second 5 V supply whose GND is tied to the chips' GND.

Still to add: screenshots of the circuit and test cases in `images/`.
