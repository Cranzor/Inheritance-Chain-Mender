# Inheritance Chain Mender
Automatically convert your Godot scripts at export to no longer use class_name, allowing for "inheritance chaining" that is commonly utilized in Godot modding.
Due to an engine bug in Godot 4.x, scripts containing a named class cannot be extended twice, which in effect breaks the way that modding often functioned in 3.x.
This plugin serves as a temporary solution until the bug is fixed, allowing you to utilize class_name within your project and still maintain modding capability.

## Usage
This plugin has been tested on a personal project, but there is a possibility that it does not account for all edge cases.
Therefore, it is recommended that you convert your project within the editor and check for errors.
If you appear to regularly have no issues doing this, you can switch your workflow to simply enabling the plugin and exporting your project like usual.

### In-Editor Conversion (Recommended Usage)

1. Add the plugin to your addons folder and back up your project. The plugin does not need to be enabled.
2. In the editor_scripts folder, run the file named "convert_files_in_editor". Reload your project once the completion message appears in the output. If you are prompted with a message to update your scripts, click "Cancel."
3. Your scripts are now converted. Check to see if any errors (edge cases) have appeared. Manually correct any that remain, and then export your project.
4. Once exported, run the "revert_files_in_editor" script in the editor_scripts folder. This will restore your original scripts. Reload your project once the completion message appears in the output.

### Export Conversion (Experimental Usage)
1. Add the plugin to your addons folder and back up your project. Make sure to enable the plugin.
2. Export your project. If you are prompted with a message to update your scripts, click "Cancel" and reload your project.
3. **Highly recommended:** Use [Godot RE Tools](https://github.com/bruvzg/gdsdecomp) on the exported project to make sure there are no errors in any scripts. This is the same environment modders will interact with.

## The Conversion Process
Each .gd file in the project goes through the following process:
- class_name is commented out
- Extensions of a global class are replaced with the file path for the class
- New instances of a class are given a constant declaration in the line above so that they function correctly
- A tag comment is added to the end of the file to mark it as being converted (this will not be visible after export as comments are deleted)
