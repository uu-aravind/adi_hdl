
# constraints


# iic

set_property  -dict {PACKAGE_PIN  AJ14  IOSTANDARD LVCMOS25 PULLTYPE PULLUP} [get_ports iic_scl]
set_property  -dict {PACKAGE_PIN  AJ18  IOSTANDARD LVCMOS25 PULLTYPE PULLUP} [get_ports iic_sda]

# gpio (switches, leds and such)

set_property  -dict {PACKAGE_PIN  AB17  IOSTANDARD LVCMOS25} [get_ports gpio_bd[0]]           ; ## GPIO_DIP_SW0
set_property  -dict {PACKAGE_PIN  AC16  IOSTANDARD LVCMOS25} [get_ports gpio_bd[1]]           ; ## GPIO_DIP_SW1
set_property  -dict {PACKAGE_PIN  AC17  IOSTANDARD LVCMOS25} [get_ports gpio_bd[2]]           ; ## GPIO_DIP_SW2
set_property  -dict {PACKAGE_PIN  AJ13  IOSTANDARD LVCMOS25} [get_ports gpio_bd[3]]           ; ## GPIO_DIP_SW3
set_property  -dict {PACKAGE_PIN  AK25  IOSTANDARD LVCMOS25} [get_ports gpio_bd[4]]           ; ## GPIO_SW_LEFT
set_property  -dict {PACKAGE_PIN  K15   IOSTANDARD LVCMOS15} [get_ports gpio_bd[5]]           ; ## GPIO_SW_CENTER
set_property  -dict {PACKAGE_PIN  R27   IOSTANDARD LVCMOS25} [get_ports gpio_bd[6]]           ; ## GPIO_SW_RIGHT

set_property  -dict {PACKAGE_PIN  Y21   IOSTANDARD LVCMOS25} [get_ports gpio_bd[7]]           ; ## GPIO_LED_LEFT
set_property  -dict {PACKAGE_PIN  G2    IOSTANDARD LVCMOS15} [get_ports gpio_bd[8]]           ; ## GPIO_LED_CENTER
set_property  -dict {PACKAGE_PIN  W21   IOSTANDARD LVCMOS25} [get_ports gpio_bd[9]]           ; ## GPIO_LED_RIGHT
set_property  -dict {PACKAGE_PIN  A17   IOSTANDARD LVCMOS15} [get_ports gpio_bd[10]]          ; ## GPIO_LED_0

set_property  -dict {PACKAGE_PIN  H14   IOSTANDARD LVCMOS15} [get_ports gpio_bd[11]]          ; ## XADC_GPIO_0
set_property  -dict {PACKAGE_PIN  J15   IOSTANDARD LVCMOS15} [get_ports gpio_bd[12]]          ; ## XADC_GPIO_1
set_property  -dict {PACKAGE_PIN  J16   IOSTANDARD LVCMOS15} [get_ports gpio_bd[13]]          ; ## XADC_GPIO_2
set_property  -dict {PACKAGE_PIN  J14   IOSTANDARD LVCMOS15} [get_ports gpio_bd[14]]          ; ## XADC_GPIO_3

# clocks

create_clock -name cpu_clk      -period 10.00 [get_pins i_system_wrapper/system_i/sys_ps7/FCLK_CLK0]
create_clock -name m200_clk     -period  5.00 [get_pins i_system_wrapper/system_i/sys_ps7/FCLK_CLK1]

create_clock -name ps7_clk_0  -period 10.00 [get_pins i_system_wrapper/system_i/sys_ps7/inst/PS7_i/FCLKCLK[0]]
create_clock -name ps7_clk_1  -period 5.00  [get_pins i_system_wrapper/system_i/sys_ps7/inst/PS7_i/FCLKCLK[1]]


set_clock_groups -asynchronous -group {cpu_clk}
set_clock_groups -asynchronous -group {m200_clk}

set_clock_groups -asynchronous -group {ps7_clk_0}
set_clock_groups -asynchronous -group {ps7_clk_1}
