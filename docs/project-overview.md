# Project Overview

## Objective
Design and demonstrate a priority-based controller that allocates limited power to requested electrical loads.

## Included designs
This repository preserves two distinct versions rather than merging their specifications:

1. `fpga/`: original multi-module FPGA implementation with five loads, a 5-bit available-power input, sequential load-state transitions, overload detection, buzzer logic, and display logic.
2. `rtl/`: a separate three-load combinational greedy allocator with a 4-bit available-power input, prepared for small-scale gate-level simulation and Tinkercad exploration.

## Original FPGA load map
| Load | Bit | Demand | Priority |
|---|---:|---:|---|
| L1 | 4 | 5 | Highest |
| L2 | 3 | 4 | 2 |
| L3 | 2 | 3 | 3 |
| L4 | 1 | 4 | 4 |
| L5 | 0 | 2 | Lowest |

## Three-load model
| Load | Demand | Priority |
|---|---:|---|
| L1 | 5 | Highest |
| L2 | 4 | Medium |
| L3 | 3 | Lowest |

For both models, requests are considered in priority order and a load is granted only when its full demand fits the remaining capacity.

## Development status
- FPGA Verilog source modules and their supplied testbenches are archived under `fpga/`.
- The three-load combinational Verilog module and exhaustive testbench are under `rtl/`.
- Tinkercad circuit remains a planned task; no Tinkercad link or screenshot is claimed yet.
