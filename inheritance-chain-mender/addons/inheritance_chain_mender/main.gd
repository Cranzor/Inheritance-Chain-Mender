@tool
extends EditorPlugin

const ExportPlugin = preload("res://addons/inheritance_chain_mender/inheritance_chain_mender.gd")
var export_plugin = ExportPlugin.new()

func _enter_tree() -> void:
	add_export_plugin(export_plugin)

func _exit_tree() -> void:
	remove_inspector_plugin(export_plugin)
