# Project Overview

## Objective

Design a controller that allocates limited power to three requested loads using a fixed priority order.

## Loads

| Load | Demand | Priority |
|---|---:|---|
| L1 | 5 units | Highest |
| L2 | 4 units | Medium |
| L3 | 3 units | Lowest |

## Inputs and outputs

- `P[3:0]`: available power, an unsigned value from 0 through 15.
- `R1`, `R2`, `R3`: request signals for L1, L2, and L3.
- `A1`, `A2`, `A3`: accepted-load outputs. A HIGH output means the load is granted power.

## Allocation policy

Inspect loads in the order L1 → L2 → L3. Accept a requested load only if its complete demand can be supplied from the remaining capacity. If a load cannot fit, skip it and continue to the next request.

## Implementation milestones

1. Define and verify the Boolean allocation logic.
2. Implement the combinational design in Verilog.
3. Recreate the circuit in Tinkercad using logic gates and switches.
4. Test the simulator circuit against the Verilog test cases.
5. Add screenshots and the share link after the Tinkercad build is complete.
