# Tinkercad Circuits Build Plan

## Goal

Recreate the **original four-bit greedy allocator**, rather than substituting the simplified one-hot tier demonstration.

## Inputs

Use seven maintained switches or logic-state inputs:

- `P3`, `P2`, `P1`, `P0` — four-bit available power.
- `R1`, `R2`, `R3` — load requests.

## Outputs

- `A1`, `A2`, `A3` — accepted-load indicators, each driving an LED through a current-limiting resistor.

## Implementation strategy

Build the threshold network from the Boolean equations in `docs/logic-design.md`, then the acceptance network. Use AND, OR, and NOT gates. Keep intermediate nodes labelled (`T3`, `T4`, etc.) in the simulator to make debugging easier.

## Build sequence

1. Add power rails and logic gates / ICs. Connect each IC's power pins as required by its simulator model.
2. Add the four power switches and three request switches. Verify each input toggles between logic 0 and logic 1.
3. Build and test threshold signals `T3`, `T4`, `T5`, `T7`, `T8`, `T9`, and `T12`.
4. Build `A1`, then `A2`, then `A3` using the dependency equations.
5. Connect the three outputs to LED indicators with appropriate series resistors.
6. Test the directed rows in `docs/test-plan.md`.
7. Save the Tinkercad circuit, copy its share URL, and capture screenshots for `images/`.
8. Record the actual component models used and any simulator-specific wiring differences.

## Status

Not yet built. Do not add a made-up share link or screenshots. Complete the circuit in Tinkercad first, then update this file with the real URL and validation results.
