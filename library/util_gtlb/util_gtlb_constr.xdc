
set_property shreg_extract no [get_cells -hier -filter {name =~ *tx_sync*}]
set_property shreg_extract no [get_cells -hier -filter {name =~ *up_xfer_toggle*}]

set_false_path -to [get_cells -hier -filter {name =~ *tx_sync_m1_reg && IS_SEQUENTIAL}]
set_false_path -from [get_cells -hier -filter {name =~ *up_xfer_toggle_reg  && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *d_xfer_state_m1_reg    && IS_SEQUENTIAL}]
set_false_path -from [get_cells -hier -filter {name =~ *d_xfer_toggle_reg   && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *up_xfer_toggle_m1_reg  && IS_SEQUENTIAL}]
set_false_path -from [get_cells -hier -filter {name =~ *d_xfer_data*        && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *up_data_status*        && IS_SEQUENTIAL}]

