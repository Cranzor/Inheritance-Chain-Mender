extends Node
#class_name Test4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	const Test1 = preload('res://test_scripts/test1.gd')
	var test1 = Test1.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
