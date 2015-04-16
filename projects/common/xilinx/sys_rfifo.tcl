
# fifo and controller (read side)

proc p_sys_rfifo {p_name m_name m_width s_width} {

  global ad_hdl_dir

  set p_instance [get_bd_cells $p_name]
  set c_instance [current_bd_instance .]

  current_bd_instance $p_instance

  set m_instance [create_bd_cell -type hier $m_name]
  current_bd_instance $m_instance

  create_bd_pin -dir I rstn

  create_bd_pin -dir I -type clk m_clk
  create_bd_pin -dir I m_rd
  create_bd_pin -dir I m_en
  create_bd_pin -dir O m_runf
  create_bd_pin -dir O -from [expr ($m_width-1)] -to 0 m_rdata

  create_bd_pin -dir I -type clk s_clk
  create_bd_pin -dir O s_rd
  create_bd_pin -dir O s_en
  create_bd_pin -dir I s_runf
  create_bd_pin -dir I -from [expr ($s_width-1)] -to 0 s_rdata

  set rfifo_ctl [create_bd_cell -type ip -vlnv analog.com:user:util_rfifo:1.0 rfifo_ctl]
  set_property -dict [list CONFIG.M_DATA_WIDTH $m_width] $rfifo_ctl
  set_property -dict [list CONFIG.S_DATA_WIDTH $s_width] $rfifo_ctl

  set rfifo_mem [create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:12.0 rfifo_mem]
  set_property -dict [list CONFIG.INTERFACE_TYPE {Native}] $rfifo_mem
  set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM}] $rfifo_mem
  set_property -dict [list CONFIG.Input_Data_Width $s_width] $rfifo_mem
  set_property -dict [list CONFIG.Input_Depth {64}] $rfifo_mem
  set_property -dict [list CONFIG.Output_Data_Width $m_width] $rfifo_mem
  set_property -dict [list CONFIG.Underflow_Flag {true}] $rfifo_mem

  connect_bd_net -net rstn                    [get_bd_pins rstn]
  connect_bd_net -net m_clk                   [get_bd_pins m_clk]
  connect_bd_net -net s_clk                   [get_bd_pins s_clk]
  connect_bd_net -net rstn                    [get_bd_pins rfifo_ctl/rstn]
  connect_bd_net -net m_clk                   [get_bd_pins rfifo_ctl/m_clk]
  connect_bd_net -net s_clk                   [get_bd_pins rfifo_ctl/s_clk]
  connect_bd_net -net m_clk                   [get_bd_pins rfifo_mem/rd_clk]
  connect_bd_net -net s_clk                   [get_bd_pins rfifo_mem/wr_clk]

  connect_bd_net -net m_rd                    [get_bd_pins m_rd]                      [get_bd_pins rfifo_ctl/m_rd]
  connect_bd_net -net m_en                    [get_bd_pins m_en]                      [get_bd_pins rfifo_ctl/m_en]
  connect_bd_net -net m_rdata                 [get_bd_pins m_rdata]                   [get_bd_pins rfifo_ctl/m_rdata]
  connect_bd_net -net m_runf                  [get_bd_pins m_runf]                    [get_bd_pins rfifo_ctl/m_runf]
  connect_bd_net -net s_rd                    [get_bd_pins s_rd]                      [get_bd_pins rfifo_ctl/s_rd]
  connect_bd_net -net s_en                    [get_bd_pins s_en]                      [get_bd_pins rfifo_ctl/s_en]
  connect_bd_net -net s_rdata                 [get_bd_pins s_rdata]                   [get_bd_pins rfifo_ctl/s_rdata]
  connect_bd_net -net s_runf                  [get_bd_pins s_runf]                    [get_bd_pins rfifo_ctl/s_runf]

  connect_bd_net -net rfifo_ctl_fifo_rst      [get_bd_pins rfifo_ctl/fifo_rst]        [get_bd_pins rfifo_mem/rst]
  connect_bd_net -net rfifo_ctl_fifo_wr       [get_bd_pins rfifo_ctl/fifo_wr]         [get_bd_pins rfifo_mem/wr_en]
  connect_bd_net -net rfifo_ctl_fifo_wdata    [get_bd_pins rfifo_ctl/fifo_wdata]      [get_bd_pins rfifo_mem/din]
  connect_bd_net -net rfifo_ctl_fifo_wfull    [get_bd_pins rfifo_ctl/fifo_wfull]      [get_bd_pins rfifo_mem/full]
  connect_bd_net -net rfifo_ctl_fifo_rd       [get_bd_pins rfifo_ctl/fifo_rd]         [get_bd_pins rfifo_mem/rd_en]
  connect_bd_net -net rfifo_ctl_fifo_rdata    [get_bd_pins rfifo_ctl/fifo_rdata]      [get_bd_pins rfifo_mem/dout]
  connect_bd_net -net rfifo_ctl_fifo_rempty   [get_bd_pins rfifo_ctl/fifo_rempty]     [get_bd_pins rfifo_mem/empty]
  connect_bd_net -net rfifo_ctl_fifo_runf     [get_bd_pins rfifo_ctl/fifo_runf]       [get_bd_pins rfifo_mem/underflow]

  current_bd_instance $c_instance
}

