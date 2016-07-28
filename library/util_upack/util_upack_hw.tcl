

package require -exact qsys 13.0
source ../scripts/adi_env.tcl
source ../scripts/adi_ip_alt.tcl


set_module_property NAME util_upack
set_module_property DESCRIPTION "Channel Pack Utility"
set_module_property VERSION 1.0
set_module_property GROUP "Analog Devices"
set_module_property DISPLAY_NAME util_upack
set_module_property ELABORATION_CALLBACK p_util_upack

# files

add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL util_upack
add_fileset_file util_upack_dmx.v   VERILOG PATH util_upack_dmx.v
add_fileset_file util_upack_dsf.v   VERILOG PATH util_upack_dsf.v
add_fileset_file util_upack.v       VERILOG PATH util_upack.v TOP_LEVEL_FILE

# parameters

add_parameter CHANNEL_DATA_WIDTH INTEGER 0
set_parameter_property CHANNEL_DATA_WIDTH DEFAULT_VALUE 32
set_parameter_property CHANNEL_DATA_WIDTH DISPLAY_NAME CHANNEL_DATA_WIDTH
set_parameter_property CHANNEL_DATA_WIDTH TYPE INTEGER
set_parameter_property CHANNEL_DATA_WIDTH UNITS None
set_parameter_property CHANNEL_DATA_WIDTH HDL_PARAMETER true

add_parameter NUM_OF_CHANNELS INTEGER 0
set_parameter_property NUM_OF_CHANNELS DEFAULT_VALUE 8
set_parameter_property NUM_OF_CHANNELS DISPLAY_NAME NUM_OF_CHANNELS
set_parameter_property NUM_OF_CHANNELS TYPE INTEGER
set_parameter_property NUM_OF_CHANNELS UNITS None
set_parameter_property NUM_OF_CHANNELS HDL_PARAMETER true

add_parameter VALID_OUTPUT_MODE BOOLEAN false
set_parameter_property VALID_OUTPUT_MODE DISPLAY_NAME "Use Valid Output"
set_parameter_property VALID_OUTPUT_MODE HDL_PARAMETER false

# defaults

ad_alt_intf clock   dac_clk         input   1
ad_alt_intf signal  dma_xfer_in     input   1                                   xfer_req
ad_alt_intf signal  dac_xfer_out    output  1                                   xfer_req
ad_alt_intf signal  dac_valid       output  1                                   valid
ad_alt_intf signal  dac_sync        output  1                                   sync
ad_alt_intf signal  dac_data        input   NUM_OF_CHANNELS*CHANNEL_DATA_WIDTH  data

add_interface fifo_ch_0 conduit end
#set_interface_property fifo_ch_0  associatedClock if_dac_clk
add_interface_port fifo_ch_0  dac_enable_0  enable   Input  1
add_interface_port fifo_ch_0  dac_valid_0   valid    Input  1
#add_interface_port fifo_ch_0  upack_valid_0 valid_o  Output  1
add_interface_port fifo_ch_0  dac_data_0    data     Output  CHANNEL_DATA_WIDTH

proc p_util_upack {} {
    for {set i 0} {$i < [get_parameter_value NUM_OF_CHANNELS]} {incr i} {
        set if fifo_ch_${i}
        add_interface ${if} conduit end
        #set_interface_property fifo_ch_${i}  associatedClock if_dac_clk
        add_interface_port ${if}  dac_enable_${i}  enable   Input  1
        if {[get_parameter_value VALID_OUTPUT_MODE]} {
            add_interface_port ${if}  upack_valid_${i} valid_o  Output  1
        }
        add_interface_port ${if}  dac_valid_${i}   valid    Input  1    
        add_interface_port ${if}  dac_data_${i}    data     Output  CHANNEL_DATA_WIDTH   
    }
}

