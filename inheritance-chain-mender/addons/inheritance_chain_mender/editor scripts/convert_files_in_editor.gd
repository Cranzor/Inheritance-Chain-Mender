@tool
extends EditorScript

func _run() -> void:
	const InheritanceChainMender = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
	var inheritance_chain_mender = InheritanceChainMender.new()
	
	inheritance_chain_mender.convert_scripts()
