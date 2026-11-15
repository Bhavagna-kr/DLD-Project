#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
command -v iverilog >/dev/null || { echo "ERROR: iverilog is required (install Icarus Verilog)." >&2; exit 127; }
command -v vvp >/dev/null || { echo "ERROR: vvp is required (install Icarus Verilog)." >&2; exit 127; }
SRC=("$ROOT"/fpga/src/*.v)
TB_DIR="$ROOT/fpga/testbenches"
run_tb() {
  local tb="$1" module="$2"
  local tmp
  tmp="$(mktemp)"
  echo "== Running $tb ($module) =="
  iverilog -g2012 -Wall -s "$module" -o "$tmp" "${SRC[@]}" "$TB_DIR/$tb"
  vvp "$tmp"
  rm -f "$tmp"
}
run_tb tb_demand_calculator.v tb_demand_calculator
run_tb tb_overload_detector.v tb_overload_detector
run_tb tb_priority_controller.v tb_priority_controller
run_tb tb_load_fsm.v tb_load_fsm
run_tb tb_top_module.v tb_top_module
