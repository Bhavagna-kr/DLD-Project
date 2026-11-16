# Priority-Based Power Load Controller — DLD Project

Digital Logic Design project containing the original five-load FPGA implementation, a separate three-load combinational allocator, Verilog testbenches, the RealDigital Boolean board constraints supplied for this project, and a Tinkercad simulation plan.

## Repository layout

```text
DLD-Project/
├── README.md
├── .gitignore
├── docs/                 # Project overview, logic design, parts, test plan
├── fpga/
│   ├── src/              # Seven core modules + fpga_top board wrapper
│   ├── testbenches/      # Five FPGA testbenches
│   └── constraints/      # Boolean board XDC supplied by the project owner
├── rtl/                  # Separate three-load combinational allocator + testbench
├── simulation/           # Test runner scripts
├── tinkercad/            # Tinkercad build plan
└── images/               # Screenshots to be added after simulation
```

## Original FPGA implementation (`fpga/`)

The FPGA implementation supports five loads with demands L1=5, L2=4, L3=3, L4=4, and L5=2, in descending priority order. Available power is a 5-bit unsigned input (0–31). The design contains a combinational priority controller, load-state FSM, demand/overload logic, buzzer output, and display driver.

Use `fpga_top` as the board-level synthesis top with `fpga/constraints/Boolean_Board_Power_Load_Controller.xdc`.

**Important constraint note:** the supplied XDC assigns pins for `led[7:0]` only, while the supplied `fpga_top.v` has a 16-bit LED output and drives `led[13:8]` with total demand. Those upper outputs require authoritative pin assignments or an intentional wrapper change before bitstream generation. No pins have been invented.

## Separate three-load combinational allocator (`rtl/`)

This is a separate model with loads L1=5, L2=4, L3=3 and a 4-bit available-power input. It is not the same design as the five-load FPGA controller.

## Run simulations

Install Icarus Verilog (`iverilog`, `vvp`) and run from repository root:

```bash
./simulation/run_fpga_tests.sh
./simulation/run_three_load_tests.sh
```

## Tinkercad status

The three-load allocator has been built at gate level (3×74HC08, 3×74HC32, 1×74HC04) and tested in Tinkercad Circuits:
https://www.tinkercad.com/things/4uLk8jznWWk-fantabulous-vihelmo

See `tinkercad/wiring-guide.md` for the pin-by-pin wiring and test table, `tinkercad/schematic.png` for the gate schematic, and `tinkercad/netlist.py` for the exhaustive 128-case check of the wiring.
