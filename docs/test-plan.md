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
Once the gate-level circuit is built, record the simulator URL, screenshots, and test results. Test each power mode and request combination, plus invalid/multiple power-mode inputs if the model uses one-hot tier signals.
