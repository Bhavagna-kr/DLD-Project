# Components and IC References

## Tinkercad component checklist

The exact available component names may vary in the simulator. The intended circuit requires:

- Logic gates: AND, OR, and NOT gates (or equivalent 74LS08, 74LS32, and 74LS04 IC models if available).
- Four input switches for `P3..P0`.
- Three input switches for `R1..R3`.
- Three output LEDs with current-limiting resistors.
- +5 V and GND power connections.

## Useful 14-pin IC references

For 74LS08 (quad 2-input AND) and 74LS32 (quad 2-input OR):

- Pin 14: VCC (+5 V)
- Pin 7: GND

| Gate | Input pins | Output pin |
|---|---|---|
| Gate 1 | 1, 2 | 3 |
| Gate 2 | 4, 5 | 6 |
| Gate 3 | 9, 10 | 8 |
| Gate 4 | 12, 13 | 11 |

For 74LS04 (hex inverter), the input/output pairs are 1→2, 3→4, 5→6, 9→8, 11→10, and 13→12. Its power pins are 14 (VCC) and 7 (GND).

## Electrical reminders for a physical build

- Never connect an LED directly to a logic output without a current-limiting resistor.
- Keep a 100 nF decoupling capacitor close to each logic IC, between its VCC and GND pins.
- Do not leave unused TTL inputs floating; tie them to a defined logic level.
- 74LS output source and sink capabilities are asymmetric. Check the chosen LED wiring/current and use a driver stage when needed.
- The earlier breadboard push-button setup did not produce valid HIGH levels. In Tinkercad, use maintained switches or logic-state inputs and verify each signal before testing the full circuit.
