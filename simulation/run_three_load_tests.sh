#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
command -v iverilog >/dev/null || { echo "ERROR: iverilog is required (install Icarus Verilog)." >&2; exit 127; }
command -v vvp >/dev/null || { echo "ERROR: vvp is required (install Icarus Verilog)." >&2; exit 127; }
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
iverilog -g2012 -Wall -s tb_priority_load_controller -o "$TMP" \
  "$ROOT/rtl/priority_load_controller.v" \
  "$ROOT/rtl/tb_priority_load_controller.v"
vvp "$TMP"
