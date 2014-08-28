# Set the list of libraries to build
set LibList [glob -type d *]

# Build each library
foreach LibItem $LibList {
	puts $LibItem
	cd $LibItem
	set ipgen_script [join [concat $LibItem "_ip.tcl"] ""]
	# make sure the _ip.tcl script exists
	if {[llength [glob -nocomplain $ipgen_script]] > 0} {
		if {[catch {source $ipgen_script} errStr]} {
			puts stderr "Failed to execute $ipgen_script\n$errStr"
		}
		close_project	
	}
	cd ..
}
