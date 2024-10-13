@tool
extends Resource

@export var saved_global_classes_array: Array = []
@export var original_scripts: Dictionary = {}
@export var gd_files: Array = []

func update_global_classes(passed_global_classes):
	saved_global_classes_array = passed_global_classes
