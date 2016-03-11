# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axi_ad9680
adi_ip_files axi_ad9680 [list \
  "$ad_hdl_dir/library/common/ad_rst.v" \
  "$ad_hdl_dir/library/common/ad_pnmon.v" \
  "$ad_hdl_dir/library/common/ad_datafmt.v" \
  "$ad_hdl_dir/library/common/up_axi.v" \
  "$ad_hdl_dir/library/common/up_xfer_cntrl.v" \
  "$ad_hdl_dir/library/common/up_xfer_status.v" \
  "$ad_hdl_dir/library/common/up_clock_mon.v" \
  "$ad_hdl_dir/library/common/up_adc_common.v" \
  "$ad_hdl_dir/library/common/up_adc_channel.v" \
  "axi_ad9680_pnmon.v" \
  "axi_ad9680_channel.v" \
  "axi_ad9680_if.v" \
  "axi_ad9680.v" \
  "$ad_hdl_dir/library/common/ad_axi_ip_constr.xdc" ]

adi_ip_properties axi_ad9680

adi_ip_constraints axi_ad9680 [list \
  "$ad_hdl_dir/library/common/ad_axi_ip_constr.xdc" ]

set_property driver_value 0 [ipx::get_ports *dovf* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *dunf* -of_objects [ipx::current_core]]

ipx::save_core [ipx::current_core]

