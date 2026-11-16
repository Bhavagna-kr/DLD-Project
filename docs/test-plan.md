# Test Plan

## Three-load combinational model
The testbench `rtl/tb_priority_load_controller.v` iterates over all 16 available-power values and all 8 request patterns (128 cases). For each case it calculates the expected result with a procedural greedy reference model and compares `{A3,A2,A1}`.

Run:

```bash
./simulation/run_three_load_tests.sh
```

## Original FPGA modules
Individual testbenches are supplied for:

- `demand_calculator`
- `overload_detector`
- `priority_controller`
- `load_fsm`
- integrated `top_module`

Run:

```bash
./simulation/run_fpga_tests.sh
```

The testbenches are the project's simulation assets. Run them with Icarus Verilog or in Vivado Simulator. Check all console output and waveforms before claiming hardware-level validation.

## Tinkercad
The gate-level circuit (3×74HC08, 3×74HC32, 1×74HC04) is built at https://www.tinkercad.com/things/4uLk8jznWWk-fantabulous-vihelmo.

It was tested in three stages (L1 only, then L1+L2, then all three loads), and the final 10-row table in `tinkercad/wiring-guide.md` matched in the simulator. The wiring netlist itself (`tinkercad/netlist.py`) is checked against all 128 input combinations in software.
