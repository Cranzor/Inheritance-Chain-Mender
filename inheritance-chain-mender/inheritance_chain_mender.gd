@tool
extends EditorScript

var global_classes
var classes_array
var overwrite_files = false
var classes_with_file_path: Dictionary = {}
var all_gd_files: Array = []
var file_counter = 0
var conversion_tag = "# Converted by Inheritance Chain Mender\n"

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	global_classes = ProjectSettings.get_global_class_list()

	# putting paths for all project files with the .gd file type into all_gd_files with a recursive search
	scan_dir_for_gd_files("res://")
	
	# generating dict that holds global class names as keys and associated file paths as values
	for global_class in global_classes:
		classes_with_file_path[global_class['class']] = global_class['path']

	for file in all_gd_files:
		var new_text = get_new_file_text(file)
		#write_new_text_to_file(file, new_text)
		file_counter += 1
		print(new_text)
		print("---------------------------------")
	
	post_conversion_print(file_counter)


func scan_dir_for_gd_files(path):
	var file_name
	var files = []
	var dir = DirAccess.open(path)
	if not dir:
		return
	
	dir.list_dir_begin()
	file_name = dir.get_next()
	while file_name!="":
		if dir.current_is_dir():
			var new_path = path+"/"+file_name
			files += scan_dir_for_gd_files(new_path)
		else:
			if file_name.get_extension() == 'gd':
				var name = path+"/"+file_name
				if name not in all_gd_files and name != "res:///inheritance_chain_mender.gd":
					all_gd_files.append(name)
				files.push_back(name)
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return files


func get_new_file_text(file):
	# open .gd file and get its text as a string
	var opened_file = FileAccess.open(file, FileAccess.READ)
	var content = opened_file.get_as_text()
	var updated_content = content
	
	if check_if_converted(content): # skipping files that have been tagged as already converted
		# file content gets updated with three different RegEx operations
		updated_content = comment_out_class_names(content) # comments out class_name so that it is no longer used
		updated_content = add_const_class_above_const_new(updated_content) # for lines containing 'Class.method()', adds a new line above with a constant declaration + proper type
		updated_content = substitute_extensions_with_paths(updated_content) # swaps out class names after 'extends' with the file path for the class
		#updated_content = conversion_tag + updated_content
	return updated_content


func check_if_converted(file_content):
	var regex = RegEx.new()
	regex.compile(conversion_tag)
	var search = regex.search(file_content)
	if search == null:
		return true
	return false


func comment_out_class_names(file_content):
	var class_name_pattern = "(?m)^(class_name +.+)"
	var class_name_sub_pattern = "#$1"
	
	var regex = RegEx.new()
	regex.compile(class_name_pattern)
	return regex.sub(file_content, class_name_sub_pattern)


func substitute_extensions_with_paths(file_content):
	for global_class in classes_with_file_path.keys():
		var extends_pattern = "(?m)^(extends) +(%s)"
		extends_pattern = extends_pattern % global_class
		var regex = RegEx.new()
		regex.compile(extends_pattern)
		
		var search = regex.search(file_content)
		if search != null:
			var search_results = search.strings
			var extends_string = search_results[1]
			var extended_class = search_results[2]
			if classes_with_file_path.has(extended_class):
				var class_file_path = classes_with_file_path[extended_class]
				return regex.sub(file_content, extends_string + " '" + class_file_path +"'")
	return file_content


func add_const_class_above_const_new(file_content):
	var updated_file_content: String = file_content
	for global_class in classes_with_file_path.keys():
		var regex = RegEx.new()
		regex.compile("(\\s*)(.*"+ global_class + "\\.)")
		
		var class_file_path = classes_with_file_path[global_class]
		var matched_spacing = "$1"
		var original_line_body_with_spacing = "$1$2"
		
		var search = regex.search(file_content)
		if search != null:
			updated_file_content = regex.sub(updated_file_content, matched_spacing + "const " +\
			 global_class + ": " + global_class + " = preload('" + class_file_path + "')" + original_line_body_with_spacing)
	return updated_file_content


func write_new_text_to_file(file, new_text):
	var opened_file = FileAccess.open(file, FileAccess.WRITE)
	opened_file.store_string(new_text)

func post_conversion_print(number):
	print(str(number) + " files converted.")
	print("Reload your project to see changes take effect.")
