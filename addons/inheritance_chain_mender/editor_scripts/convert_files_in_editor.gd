# This script is for manually converting your files within the editor.
# Use File -> Run for it to start, and then Project -> Reload Current project to see changes take effect.
# Check for errors and then export the project when none remain.

@tool
extends EditorScript

func _run() -> void:
	const InheritanceChainMender = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
	var inheritance_chain_mender: InheritanceChainMender = InheritanceChainMender.new()
	
	inheritance_chain_mender.convert_scripts()
	
	if inheritance_chain_mender.conversion_completed:
		print_rich("[color=YELLOW_GREEN]Finished converting files. Restart the editor to see changes take effect.")
