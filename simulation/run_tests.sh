#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
iverilog -g2012 -Wall -o simulation/priority_load_controller_tb \
  rtl/priority_load_controller.v rtl/tb_priority_load_controller.v
vvp simulation/priority_load_controller_tb
rm -f simulation/priority_load_controller_tb
