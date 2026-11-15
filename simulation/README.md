# Simulation scripts

Install Icarus Verilog (`iverilog` and `vvp`) before running these scripts.

From the repository root:

```bash
./simulation/run_three_load_tests.sh
./simulation/run_fpga_tests.sh
```

The three-load testbench exhaustively checks all 128 combinations of 4-bit available power and three request inputs. The FPGA test runner executes each of the five supplied module/integration testbenches independently.
