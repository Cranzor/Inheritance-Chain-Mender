# Runs at time of export

@tool
extends EditorExportPlugin

const InheritanceChainMender = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
var inheritance_chain_mender: InheritanceChainMender =  InheritanceChainMender.new()

func _get_name() -> String:
	return "Inheritance Chain Mender"

func _export_begin(features, is_debug, path, flags) -> void:
	inheritance_chain_mender.convert_scripts()

func _export_end() -> void:
	inheritance_chain_mender.revert_scripts_to_originals()
	print_rich("[color=YELLOW]Export finished.")
