@tool
extends EditorScript

func _run() -> void:
	const InheritanceChainMender = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
	var inheritance_chain_mender = InheritanceChainMender.new()
	
	inheritance_chain_mender.convert_scripts()
	
	if inheritance_chain_mender.conversion_completed:
		print_rich("[color=YELLOW_GREEN]Finished converting files. Restart the editor to see changes take effect.")
