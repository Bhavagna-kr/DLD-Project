# Priority-Based Power Load Controller — FPGA Implementation

## Design sources
- `src/top_module.v` — core controller top module
- `src/priority_controller.v`
- `src/demand_calculator.v`
- `src/overload_detector.v`
- `src/load_fsm.v`
- `src/display_controller.v`
- `src/fpga_top.v` — board-level wrapper supplied for the RealDigital Boolean board

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
Use **`fpga_top` as the synthesis top** with `constraints/Boolean_Board_Power_Load_Controller.xdc`.

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

### Constraint limitation to resolve before bitstream generation
The supplied XDC contains physical pin assignments only for `led[7:0]`, while the provided `fpga_top.v` declares `led[15:0]` and also drives `led[13:8]` with `total_demand` and `led[15:14]` low. Those upper eight outputs are **not constrained by this XDC**. Do not generate/program a bitstream until either (a) authoritative board pin mappings for `led[15:8]` are added, or (b) the wrapper is intentionally reduced to an 8-bit LED output and the total-demand LED display is removed. No additional board pins have been guessed here.

The XDC also constrains only `pb[4]`; this matches the wrapper usage because only `pb[4]` is referenced.

## Vivado setup
1. Create an RTL project for the exact FPGA part/revision of the RealDigital Boolean board.
2. Add all `.v` files in `src/` as Design Sources.
3. Add `testbenches/` files as Simulation Sources when simulating.
4. Add `constraints/Boolean_Board_Power_Load_Controller.xdc` as a constraints file.
5. Set `fpga_top` as the synthesis top and `tb_top_module` as the integrated simulation top.
6. Run behavioral simulation before synthesis.
7. Resolve all unconstrained-port/DRC warnings using the board's authoritative master XDC before bitstream generation.

## Simulation
From the repository root:

```bash
./simulation/run_fpga_tests.sh
```

The runner executes five testbenches. Icarus Verilog (`iverilog` and `vvp`) is required.

## Hardware notes
The FSM starts with loads OFF after reset, sheds the lowest-priority active load first, and restores loads in priority order. The default step count is 50,000,000 cycles (one second at 50 MHz).
