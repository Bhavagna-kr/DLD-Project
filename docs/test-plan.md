# Test Plan

## Exhaustive verification

There are four power-input bits and three request bits, so the full input space contains 16 × 8 = 128 combinations. The Verilog testbench checks every combination against the greedy allocation algorithm.

## Directed examples

| P | R1 | R2 | R3 | A1 | A2 | A3 | Explanation |
|---:|---:|---:|---:|---:|---:|---:|---|
| 0 | 1 | 1 | 1 | 0 | 0 | 0 | No load fits |
| 3 | 0 | 0 | 1 | 0 | 0 | 1 | L3 alone fits |
| 4 | 0 | 1 | 1 | 0 | 1 | 0 | L2 fits; L3 does not fit after L2 |
| 5 | 1 | 1 | 1 | 1 | 0 | 0 | L1 fits; no capacity remains |
| 7 | 0 | 1 | 1 | 0 | 1 | 1 | L2 and L3 fit together |
| 8 | 1 | 0 | 1 | 1 | 0 | 1 | L1 and L3 fit together |
| 9 | 1 | 1 | 1 | 1 | 1 | 0 | L1 and L2 fit; L3 does not |
| 12 | 1 | 1 | 1 | 1 | 1 | 1 | All three fit |

## Tinkercad validation

After constructing the circuit, run these directed examples first, then extend to all 128 combinations if feasible. Record any mismatch before describing the Tinkercad implementation as verified.
