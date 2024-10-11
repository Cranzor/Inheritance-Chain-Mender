extends Node
class_name Test3

var test2 = Test2.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test2.test_func()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
