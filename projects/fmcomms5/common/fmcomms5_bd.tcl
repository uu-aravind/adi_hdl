
# fmcomms5

# master

create_bd_port -dir I rx_clk_in_0_p
create_bd_port -dir I rx_clk_in_0_n
create_bd_port -dir I rx_frame_in_0_p
create_bd_port -dir I rx_frame_in_0_n
create_bd_port -dir I -from 5 -to 0 rx_data_in_0_p
create_bd_port -dir I -from 5 -to 0 rx_data_in_0_n
create_bd_port -dir O tx_clk_out_0_p
create_bd_port -dir O tx_clk_out_0_n
create_bd_port -dir O tx_frame_out_0_p
create_bd_port -dir O tx_frame_out_0_n
create_bd_port -dir O -from 5 -to 0 tx_data_out_0_p
create_bd_port -dir O -from 5 -to 0 tx_data_out_0_n

# slave

create_bd_port -dir I rx_clk_in_1_p
create_bd_port -dir I rx_clk_in_1_n
create_bd_port -dir I rx_frame_in_1_p
create_bd_port -dir I rx_frame_in_1_n
create_bd_port -dir I -from 5 -to 0 rx_data_in_1_p
create_bd_port -dir I -from 5 -to 0 rx_data_in_1_n
create_bd_port -dir O tx_clk_out_1_p
create_bd_port -dir O tx_clk_out_1_n
create_bd_port -dir O tx_frame_out_1_p
create_bd_port -dir O tx_frame_out_1_n
create_bd_port -dir O -from 5 -to 0 tx_data_out_1_p
create_bd_port -dir O -from 5 -to 0 tx_data_out_1_n

create_bd_port -dir O sys_100m_resetn

# instances

set axi_ad9361_0 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_0]
set_property -dict [list CONFIG.ID {0}] $axi_ad9361_0
set_property -dict [list CONFIG.IO_DELAY_GROUP {dev_0_if_delay_group}] $axi_ad9361_0

set axi_ad9361_1 [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9361:1.0 axi_ad9361_1]
set_property -dict [list CONFIG.ID {1}] $axi_ad9361_1
set_property -dict [list CONFIG.IO_DELAY_GROUP {dev_1_if_delay_group}] $axi_ad9361_1

set axi_ad9361_dac_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_dac_dma]
set_property -dict [list CONFIG.DMA_TYPE_SRC {0}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.DMA_TYPE_DEST {2}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.CYCLIC {1}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.SYNC_TRANSFER_START {0}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.AXI_SLICE_SRC {0}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.AXI_SLICE_DEST {1}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.DMA_2D_TRANSFER {0}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.DMA_DATA_WIDTH_DEST {128}] $axi_ad9361_dac_dma
set_property -dict [list CONFIG.DMA_DATA_WIDTH_SRC {128}] $axi_ad9361_dac_dma

if {$sys_zynq == 1} {
  set_property -dict [list CONFIG.DMA_AXI_PROTOCOL_SRC {1}] $axi_ad9361_dac_dma
  set_property -dict [list CONFIG.DMA_DATA_WIDTH_SRC {64}] $axi_ad9361_dac_dma
}

set axi_ad9361_adc_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9361_adc_dma]
set_property -dict [list CONFIG.DMA_TYPE_SRC {2}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.DMA_TYPE_DEST {0}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.CYCLIC {0}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.SYNC_TRANSFER_START {1}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.AXI_SLICE_SRC {1}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.AXI_SLICE_DEST {0}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.DMA_2D_TRANSFER {0}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.DMA_DATA_WIDTH_DEST {128}] $axi_ad9361_adc_dma
set_property -dict [list CONFIG.DMA_DATA_WIDTH_SRC {128}] $axi_ad9361_adc_dma

if {$sys_zynq == 1} {
  set_property -dict [list CONFIG.DMA_AXI_PROTOCOL_DEST {1}] $axi_ad9361_adc_dma
  set_property -dict [list CONFIG.DMA_DATA_WIDTH_DEST {64}] $axi_ad9361_adc_dma
}

set util_upack_dac [create_bd_cell -type ip -vlnv analog.com:user:util_upack:1.0 util_upack_dac]
set_property -dict [list CONFIG.CHANNEL_DATA_WIDTH {16}] $util_upack_dac
set_property -dict [list CONFIG.NUM_OF_CHANNELS {8}] $util_upack_dac

set util_cpack_adc [create_bd_cell -type ip -vlnv analog.com:user:util_cpack:1.0 util_cpack_adc]
set_property -dict [list CONFIG.CHANNEL_DATA_WIDTH {16}] $util_cpack_adc
set_property -dict [list CONFIG.NUM_OF_CHANNELS {8}] $util_cpack_adc

set adc_wfifo [create_bd_cell -type ip -vlnv analog.com:user:util_wfifo:1.0 adc_wfifo]
set_property -dict [list CONFIG.NUM_OF_CHANNELS {8} ] $adc_wfifo
set_property -dict [list CONFIG.DIN_DATA_WIDTH {16} ] $adc_wfifo
set_property -dict [list CONFIG.DOUT_DATA_WIDTH {16} ] $adc_wfifo
set_property -dict [list CONFIG.DIN_ADDRESS_WIDTH {4}] $adc_wfifo

# connections (ad9361)

ad_connect sys_200m_clk     axi_ad9361_0/delay_clk
ad_connect sys_200m_clk     axi_ad9361_1/delay_clk
ad_connect axi_ad9361_0_clk axi_ad9361_0/l_clk
ad_connect axi_ad9361_1_clk axi_ad9361_1/l_clk
ad_connect axi_ad9361_0_clk axi_ad9361_0/clk
ad_connect axi_ad9361_0_clk axi_ad9361_1/clk
ad_connect axi_ad9361_0/rst adc_wfifo/din_rst
ad_connect axi_ad9361_0_clk adc_wfifo/din_clk
ad_connect sys_cpu_clk      adc_wfifo/dout_clk
ad_connect sys_cpu_resetn   adc_wfifo/dout_rstn
ad_connect sys_cpu_clk      util_cpack_adc/adc_clk
ad_connect sys_cpu_clk      axi_ad9361_adc_dma/fifo_wr_clk
ad_connect axi_ad9361_0_clk util_upack_dac/dac_clk
ad_connect axi_ad9361_0_clk axi_ad9361_dac_dma/fifo_rd_clk
ad_connect sys_cpu_resetn   sys_100m_resetn
ad_connect sys_cpu_resetn   axi_ad9361_adc_dma/m_dest_axi_aresetn
ad_connect sys_cpu_resetn   axi_ad9361_dac_dma/m_src_axi_aresetn
ad_connect sys_cpu_reset    util_cpack_adc/adc_rst


ad_connect  axi_ad9361_0_dac_sync   axi_ad9361_0/dac_sync_out
ad_connect  axi_ad9361_0_dac_sync   axi_ad9361_0/dac_sync_in
ad_connect  axi_ad9361_0_dac_sync   axi_ad9361_1/dac_sync_in

ad_connect  rx_clk_in_0_p               axi_ad9361_0/rx_clk_in_p
ad_connect  rx_clk_in_0_n               axi_ad9361_0/rx_clk_in_n
ad_connect  rx_frame_in_0_p             axi_ad9361_0/rx_frame_in_p
ad_connect  rx_frame_in_0_n             axi_ad9361_0/rx_frame_in_n
ad_connect  rx_data_in_0_p              axi_ad9361_0/rx_data_in_p
ad_connect  rx_data_in_0_n              axi_ad9361_0/rx_data_in_n
ad_connect  tx_clk_out_0_p              axi_ad9361_0/tx_clk_out_p
ad_connect  tx_clk_out_0_n              axi_ad9361_0/tx_clk_out_n
ad_connect  tx_frame_out_0_p            axi_ad9361_0/tx_frame_out_p
ad_connect  tx_frame_out_0_n            axi_ad9361_0/tx_frame_out_n
ad_connect  tx_data_out_0_p             axi_ad9361_0/tx_data_out_p
ad_connect  tx_data_out_0_n             axi_ad9361_0/tx_data_out_n
ad_connect  rx_clk_in_1_p               axi_ad9361_1/rx_clk_in_p
ad_connect  rx_clk_in_1_n               axi_ad9361_1/rx_clk_in_n
ad_connect  rx_frame_in_1_p             axi_ad9361_1/rx_frame_in_p
ad_connect  rx_frame_in_1_n             axi_ad9361_1/rx_frame_in_n
ad_connect  rx_data_in_1_p              axi_ad9361_1/rx_data_in_p
ad_connect  rx_data_in_1_n              axi_ad9361_1/rx_data_in_n
ad_connect  tx_clk_out_1_p              axi_ad9361_1/tx_clk_out_p
ad_connect  tx_clk_out_1_n              axi_ad9361_1/tx_clk_out_n
ad_connect  tx_frame_out_1_p            axi_ad9361_1/tx_frame_out_p
ad_connect  tx_frame_out_1_n            axi_ad9361_1/tx_frame_out_n
ad_connect  tx_data_out_1_p             axi_ad9361_1/tx_data_out_p
ad_connect  tx_data_out_1_n             axi_ad9361_1/tx_data_out_n



ad_connect  axi_ad9361_0/adc_enable_i0  adc_wfifo/din_enable_0 
ad_connect  axi_ad9361_0/adc_valid_i0   adc_wfifo/din_valid_0
ad_connect  axi_ad9361_0/adc_data_i0    adc_wfifo/din_data_0
ad_connect  axi_ad9361_0/adc_enable_q0  adc_wfifo/din_enable_1
ad_connect  axi_ad9361_0/adc_valid_q0   adc_wfifo/din_valid_1
ad_connect  axi_ad9361_0/adc_data_q0    adc_wfifo/din_data_1
ad_connect  axi_ad9361_0/adc_enable_i1  adc_wfifo/din_enable_2
ad_connect  axi_ad9361_0/adc_valid_i1   adc_wfifo/din_valid_2
ad_connect  axi_ad9361_0/adc_data_i1    adc_wfifo/din_data_2
ad_connect  axi_ad9361_0/adc_enable_q1  adc_wfifo/din_enable_3
ad_connect  axi_ad9361_0/adc_valid_q1   adc_wfifo/din_valid_3
ad_connect  axi_ad9361_0/adc_data_q1    adc_wfifo/din_data_3
ad_connect  axi_ad9361_1/adc_enable_i0  adc_wfifo/din_enable_4
ad_connect  axi_ad9361_1/adc_valid_i0   adc_wfifo/din_valid_4
ad_connect  axi_ad9361_1/adc_data_i0    adc_wfifo/din_data_4
ad_connect  axi_ad9361_1/adc_enable_q0  adc_wfifo/din_enable_5
ad_connect  axi_ad9361_1/adc_valid_q0   adc_wfifo/din_valid_5
ad_connect  axi_ad9361_1/adc_data_q0    adc_wfifo/din_data_5
ad_connect  axi_ad9361_1/adc_enable_i1  adc_wfifo/din_enable_6
ad_connect  axi_ad9361_1/adc_valid_i1   adc_wfifo/din_valid_6
ad_connect  axi_ad9361_1/adc_data_i1    adc_wfifo/din_data_6
ad_connect  axi_ad9361_1/adc_enable_q1  adc_wfifo/din_enable_7
ad_connect  axi_ad9361_1/adc_valid_q1   adc_wfifo/din_valid_7
ad_connect  axi_ad9361_1/adc_data_q1    adc_wfifo/din_data_7    

ad_connect  util_cpack_adc/adc_enable_0  adc_wfifo/dout_enable_0 
ad_connect  util_cpack_adc/adc_valid_0   adc_wfifo/dout_valid_0
ad_connect  util_cpack_adc/adc_data_0    adc_wfifo/dout_data_0
ad_connect  util_cpack_adc/adc_enable_1  adc_wfifo/dout_enable_1
ad_connect  util_cpack_adc/adc_valid_1   adc_wfifo/dout_valid_1
ad_connect  util_cpack_adc/adc_data_1    adc_wfifo/dout_data_1
ad_connect  util_cpack_adc/adc_enable_2  adc_wfifo/dout_enable_2
ad_connect  util_cpack_adc/adc_valid_2   adc_wfifo/dout_valid_2
ad_connect  util_cpack_adc/adc_data_2    adc_wfifo/dout_data_2
ad_connect  util_cpack_adc/adc_enable_3  adc_wfifo/dout_enable_3
ad_connect  util_cpack_adc/adc_valid_3   adc_wfifo/dout_valid_3
ad_connect  util_cpack_adc/adc_data_3    adc_wfifo/dout_data_3
ad_connect  util_cpack_adc/adc_enable_4  adc_wfifo/dout_enable_4
ad_connect  util_cpack_adc/adc_valid_4   adc_wfifo/dout_valid_4
ad_connect  util_cpack_adc/adc_data_4    adc_wfifo/dout_data_4
ad_connect  util_cpack_adc/adc_enable_5  adc_wfifo/dout_enable_5
ad_connect  util_cpack_adc/adc_valid_5   adc_wfifo/dout_valid_5
ad_connect  util_cpack_adc/adc_data_5    adc_wfifo/dout_data_5
ad_connect  util_cpack_adc/adc_enable_6  adc_wfifo/dout_enable_6
ad_connect  util_cpack_adc/adc_valid_6   adc_wfifo/dout_valid_6
ad_connect  util_cpack_adc/adc_data_6    adc_wfifo/dout_data_6
ad_connect  util_cpack_adc/adc_enable_7  adc_wfifo/dout_enable_7
ad_connect  util_cpack_adc/adc_valid_7   adc_wfifo/dout_valid_7
ad_connect  util_cpack_adc/adc_data_7    adc_wfifo/dout_data_7

ad_connect  util_cpack_adc/adc_valid    axi_ad9361_adc_dma/fifo_wr_en
ad_connect  util_cpack_adc/adc_sync     axi_ad9361_adc_dma/fifo_wr_sync
ad_connect  util_cpack_adc/adc_data     axi_ad9361_adc_dma/fifo_wr_din
ad_connect  axi_ad9361_0/dac_enable_i0  util_upack_dac/dac_enable_0
ad_connect  axi_ad9361_0/dac_valid_i0   util_upack_dac/dac_valid_0
ad_connect  axi_ad9361_0/dac_data_i0    util_upack_dac/dac_data_0
ad_connect  axi_ad9361_0/dac_enable_q0  util_upack_dac/dac_enable_1
ad_connect  axi_ad9361_0/dac_valid_q0   util_upack_dac/dac_valid_1
ad_connect  axi_ad9361_0/dac_data_q0    util_upack_dac/dac_data_1
ad_connect  axi_ad9361_0/dac_enable_i1  util_upack_dac/dac_enable_2
ad_connect  axi_ad9361_0/dac_valid_i1   util_upack_dac/dac_valid_2
ad_connect  axi_ad9361_0/dac_data_i1    util_upack_dac/dac_data_2
ad_connect  axi_ad9361_0/dac_enable_q1  util_upack_dac/dac_enable_3
ad_connect  axi_ad9361_0/dac_valid_q1   util_upack_dac/dac_valid_3
ad_connect  axi_ad9361_0/dac_data_q1    util_upack_dac/dac_data_3
ad_connect  axi_ad9361_1/dac_enable_i0  util_upack_dac/dac_enable_4
ad_connect  axi_ad9361_1/dac_valid_i0   util_upack_dac/dac_valid_4
ad_connect  axi_ad9361_1/dac_data_i0    util_upack_dac/dac_data_4
ad_connect  axi_ad9361_1/dac_enable_q0  util_upack_dac/dac_enable_5
ad_connect  axi_ad9361_1/dac_valid_q0   util_upack_dac/dac_valid_5
ad_connect  axi_ad9361_1/dac_data_q0    util_upack_dac/dac_data_5
ad_connect  axi_ad9361_1/dac_enable_i1  util_upack_dac/dac_enable_6
ad_connect  axi_ad9361_1/dac_valid_i1   util_upack_dac/dac_valid_6
ad_connect  axi_ad9361_1/dac_data_i1    util_upack_dac/dac_data_6
ad_connect  axi_ad9361_1/dac_enable_q1  util_upack_dac/dac_enable_7
ad_connect  axi_ad9361_1/dac_valid_q1   util_upack_dac/dac_valid_7
ad_connect  axi_ad9361_1/dac_data_q1    util_upack_dac/dac_data_7
ad_connect  util_upack_dac/dac_valid    axi_ad9361_dac_dma/fifo_rd_en
ad_connect  util_upack_dac/dac_data     axi_ad9361_dac_dma/fifo_rd_dout
ad_connect  axi_ad9361_0/adc_dovf       axi_ad9361_adc_dma/fifo_wr_overflow
ad_connect  axi_ad9361_0/dac_dunf       axi_ad9361_dac_dma/fifo_rd_underflow

# address map

ad_cpu_interconnect 0x79020000 axi_ad9361_0
ad_cpu_interconnect 0x7C420000 axi_ad9361_dac_dma
ad_cpu_interconnect 0x7C400000 axi_ad9361_adc_dma
ad_cpu_interconnect 0x79040000 axi_ad9361_1
ad_mem_hp2_interconnect sys_dma_clk sys_ps7/S_AXI_HP2
ad_mem_hp2_interconnect sys_dma_clk axi_ad9361_adc_dma/m_dest_axi
ad_mem_hp3_interconnect sys_dma_clk sys_ps7/S_AXI_HP3
ad_mem_hp3_interconnect sys_dma_clk axi_ad9361_dac_dma/m_src_axi

# interrupts

ad_cpu_interrupt ps-12 mb-12 axi_ad9361_dac_dma/irq
ad_cpu_interrupt ps-13 mb-13 axi_ad9361_adc_dma/irq
