# Set the list of libraries to build
set LibList [glob -type d *]
set ArchiveDir "archive"
set IGNORE_VERSION_CHECK 1
file delete -force $ArchiveDir
file mkdir $ArchiveDir

# Build each library
foreach LibItem $LibList {
	puts $LibItem
	if {$LibItem == "interfaces"} {
        set isIP 0
    } else {
        set isIP 1
    }
    cd $LibItem
	set ipgen_script "${LibItem}_ip.tcl"
	# make sure the _ip.tcl script exists
	if {[llength [glob -nocomplain $ipgen_script]] > 0} {
		if {[catch {source $ipgen_script} errStr]} {
			puts stderr "Failed to execute $ipgen_script\n$errStr"
			catch {close_project}
			continue
		}
        if { $isIP } {
            set vendor [get_property vendor [ipx::current_core]]
            set library [get_property library [ipx::current_core]]
            set version [get_property version [ipx::current_core]]
            set ZipFile "../${ArchiveDir}/${vendor}_${library}_${LibItem}_${version}.zip"
            ipx::check_integrity -quiet [ipx::current_core]
            ipx::archive_core $ZipFile [ipx::current_core]
            close_project	
        }
	}
	cd ..
}
