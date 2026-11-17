## 100 MHz System Clock
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports BOARDCLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports BOARDCLK]

## Four-Bit Binary Input (SW0-SW3)
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports {N[0]}]
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports {N[1]}]
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports {N[2]}]
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports {N[3]}]

## Active-Low Reset (SW4)
set_property -dict { PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports RST_N]

## GO Pushbutton (Center Button)
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports GO]

## DONE Indicator (LED0)
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports DONE]

## Seven-Segment Outputs (Active-Low)
set_property -dict { PACKAGE_PIN W7 IOSTANDARD LVCMOS33 } [get_ports A]
set_property -dict { PACKAGE_PIN W6 IOSTANDARD LVCMOS33 } [get_ports B]
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports C]
set_property -dict { PACKAGE_PIN V8 IOSTANDARD LVCMOS33 } [get_ports D]
set_property -dict { PACKAGE_PIN U5 IOSTANDARD LVCMOS33 } [get_ports E]
set_property -dict { PACKAGE_PIN V5 IOSTANDARD LVCMOS33 } [get_ports F]
set_property -dict { PACKAGE_PIN U7 IOSTANDARD LVCMOS33 } [get_ports G]

## Four Seven-Segment Digit Enables (Active-Low)
set_property -dict { PACKAGE_PIN U2 IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[0]}]
set_property -dict { PACKAGE_PIN U4 IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[1]}]
set_property -dict { PACKAGE_PIN V4 IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[2]}]
set_property -dict { PACKAGE_PIN W4 IOSTANDARD LVCMOS33 } [get_ports {ONECOLD[3]}]
