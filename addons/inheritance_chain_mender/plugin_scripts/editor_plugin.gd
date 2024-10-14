# Runs when the plugin is enabled

@tool
extends EditorPlugin

const ExportPlugin = preload("res://addons/inheritance_chain_mender/plugin_scripts/export_plugin.gd")
var export_plugin: ExportPlugin = ExportPlugin.new()

func _enter_tree() -> void:
	add_export_plugin(export_plugin)
	print_rich("[color=YELLOW]Inheritance Chain Mender enabled. Script files in your exported project will be automatically converted to no longer use class_name.")

func _exit_tree() -> void:
	remove_export_plugin(export_plugin)
	print_rich("[color=YELLOW]Inheritance Chain Mender disabled.")
