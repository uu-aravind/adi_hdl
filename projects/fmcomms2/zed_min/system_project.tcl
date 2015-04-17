


source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl

adi_project_create fmcomms2_zed
adi_project_files fmcomms2_zed [list \
  "system_top.v" \
  "system_constr.xdc"\
  "$ad_hdl_dir/projects/common/zed_min/zed_system_constr.xdc" ]

adi_project_run fmcomms2_zed


