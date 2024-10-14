# This script is for manually reverting your files back to their original content.
# Use File -> Run for it to start, and then Project -> Reload Current project to see changes take effect.

@tool
extends EditorScript

func _run() -> void:
	const InheritanceChainMender = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
	var inheritance_chain_mender = InheritanceChainMender.new()
	
	inheritance_chain_mender.revert_scripts_to_originals()
	
	if inheritance_chain_mender.reversion_completed:
		print_rich("[color=YELLOW_GREEN]Finished reverting files back to their originals. Restart the editor to see changes take effect.")
