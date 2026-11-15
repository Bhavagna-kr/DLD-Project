## Configuration voltage
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## 50 MHz clock
set_property -dict { PACKAGE_PIN N11 IOSTANDARD LVCMOS33 } [get_ports {clk}]
create_clock -period 20.000 -name sys_clk_pin [get_ports {clk}]

## Switches SW[0:9]
set_property -dict { PACKAGE_PIN L5 IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN L4 IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN M4 IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN M2 IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
set_property -dict { PACKAGE_PIN M1 IOSTANDARD LVCMOS33 } [get_ports {sw[4]}]
set_property -dict { PACKAGE_PIN N3 IOSTANDARD LVCMOS33 } [get_ports {sw[5]}]
set_property -dict { PACKAGE_PIN N2 IOSTANDARD LVCMOS33 } [get_ports {sw[6]}]
set_property -dict { PACKAGE_PIN N1 IOSTANDARD LVCMOS33 } [get_ports {sw[7]}]
set_property -dict { PACKAGE_PIN P1 IOSTANDARD LVCMOS33 } [get_ports {sw[8]}]
set_property -dict { PACKAGE_PIN P4 IOSTANDARD LVCMOS33 } [get_ports {sw[9]}]

## LEDs
set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN H3 IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN J1 IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN K1 IOSTANDARD LVCMOS33 } [get_ports {led[3]}]
set_property -dict { PACKAGE_PIN L3 IOSTANDARD LVCMOS33 } [get_ports {led[4]}]
set_property -dict { PACKAGE_PIN L2 IOSTANDARD LVCMOS33 } [get_ports {led[5]}]
set_property -dict { PACKAGE_PIN K3 IOSTANDARD LVCMOS33 } [get_ports {led[6]}]
set_property -dict { PACKAGE_PIN K2 IOSTANDARD LVCMOS33 } [get_ports {led[7]}]

## Push button PB4 (reset)
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 PULLDOWN true } [get_ports {pb[4]}]

## Buzzer
set_property -dict { PACKAGE_PIN K12 IOSTANDARD LVCMOS33 } [get_ports {Buzzer}]
