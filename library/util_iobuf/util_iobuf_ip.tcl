# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create util_iobuf
adi_ip_files util_iobuf [list \
  "util_iobuf.v" ]

adi_ip_properties_lite util_iobuf


set_property vendor {mathworks.com} [ipx::current_core]
set_property vendor_display_name {MathWorks} [ipx::current_core]
set_property company_url {www.mathworks.com} [ipx::current_core]

set_property value_validation_range_minimum {1} [ipx::get_user_parameter BUS_WIDTH [ipx::current_core]]
set_property value_validation_range_minimum {1} [ipx::get_hdl_parameter BUS_WIDTH [ipx::current_core]]
set_property value_validation_range_maximum {1024} [ipx::get_user_parameter BUS_WIDTH [ipx::current_core]]
set_property value_validation_range_maximum {1024} [ipx::get_hdl_parameter BUS_WIDTH [ipx::current_core]]

ipx::create_xgui_files [ipx::current_core]

ipx::save_core [ipx::current_core]

