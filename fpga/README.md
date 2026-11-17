# Priority-Based Power Load Controller — FPGA Implementation

## Design sources
- `src/top_module.v` — core controller top module
- `src/priority_controller.v`
- `src/demand_calculator.v`
- `src/overload_detector.v`
- `src/load_fsm.v`
- `src/display_controller.v`
- `src/fpga_top.v` — board-level wrapper for the EDGE Artix-7 board

## Testbenches
`testbenches/` contains five testbenches for demand calculation, overload detection, priority allocation, the FSM, and the integrated `top_module`.

## Load mapping
- `load_request[4]` / `load_status[4]`: L1, demand 5 (highest priority)
- `load_request[3]` / `load_status[3]`: L2, demand 4
- `load_request[2]` / `load_status[2]`: L3, demand 3
- `load_request[1]` / `load_status[1]`: L4, demand 4
- `load_request[0]` / `load_status[0]`: L5, demand 2 (lowest priority)

Available power is 5 bits (0–31); total demand is 6 bits (0–18).

## Board wrapper and XDC
Use **`fpga_top` as the synthesis top** with `constraints/EDGE_Artix7_Power_Load_Controller.xdc`.

The wrapper maps:

| Board signal | Controller signal | Meaning |
|---|---|---|
| `sw[4:0]` | `available_power[4:0]` | Binary available power |
| `sw[9:5]` | `load_request[4:0]` | Requests L5..L1, bit 0 is L5 and bit 4 is L1 |
| `pb[4]` | `reset` | Reset input |
| `led[4:0]` | `load_status[4:0]` | Load status |
| `led[5]` | `overload` | Overload indicator |
| `led[6]` | `normal` | Normal indicator |
| `led[7]` | `busy` | Transition indicator |
| `clk` | `clk` | 50 MHz clock (20 ns period) |

The wrapper uses an 8-bit LED output (`led[7:0]`), matching the pins constrained in the XDC.

The XDC also constrains only `pb[4]`; this matches the wrapper usage because only `pb[4]` is referenced.

## Vivado setup
1. Create an RTL project for part **`xc7a35tftg256-1`** (EDGE Artix-7 board).
2. Add all `.v` files in `src/` as Design Sources.
3. Add `testbenches/` files as Simulation Sources when simulating.
4. Add `constraints/EDGE_Artix7_Power_Load_Controller.xdc` as a constraints file.
5. Set `fpga_top` as the synthesis top and `tb_top_module` as the integrated simulation top.
6. Run behavioral simulation before synthesis.
7. Run synthesis, implementation and Generate Bitstream, then program the board through Hardware Manager.

## Simulation
From the repository root:

```bash
./simulation/run_fpga_tests.sh
```

The runner executes five testbenches. Icarus Verilog (`iverilog` and `vvp`) is required.

## Hardware notes
The FSM starts with loads OFF after reset, sheds the lowest-priority active load first, and restores loads in priority order. The default step count is 50,000,000 cycles (one second at 50 MHz).
