# Clock
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports BOARDCLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports BOARDCLK]

# Inputs
set_property -dict { PACKAGE_PIN R2 IOSTANDARD LVCMOS33 } [get_ports { N[0] }]
set_property -dict { PACKAGE_PIN T1 IOSTANDARD LVCMOS33 } [get_ports { N[1] }]
set_property -dict { PACKAGE_PIN U1 IOSTANDARD LVCMOS33 } [get_ports { N[2] }]
set_property -dict { PACKAGE_PIN W2 IOSTANDARD LVCMOS33 } [get_ports { N[3] }]

set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports RST_N]
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports GO]

# LEDs
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports DONE]

# 7-Segment Displays
set_property -dict { PACKAGE_PIN W7 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[0] }]
set_property -dict { PACKAGE_PIN W6 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[1] }]
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[2] }]
set_property -dict { PACKAGE_PIN V8 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[3] }]
set_property -dict { PACKAGE_PIN U5 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[4] }]
set_property -dict { PACKAGE_PIN V5 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[5] }]
set_property -dict { PACKAGE_PIN U7 IOSTANDARD LVCMOS33 } [get_ports { SEGMENTS[6] }]

set_property -dict { PACKAGE_PIN U2 IOSTANDARD LVCMOS33 } [get_ports { ONECOLD[0] }]
set_property -dict { PACKAGE_PIN U4 IOSTANDARD LVCMOS33 } [get_ports { ONECOLD[1] }]
set_property -dict { PACKAGE_PIN V4 IOSTANDARD LVCMOS33 } [get_ports { ONECOLD[2] }]
set_property -dict { PACKAGE_PIN W4 IOSTANDARD LVCMOS33 } [get_ports { ONECOLD[3] }]
