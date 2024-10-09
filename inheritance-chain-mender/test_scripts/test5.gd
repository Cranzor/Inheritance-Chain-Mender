extends Test4
class_name Test5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var test1 = Test1.new()
	var test2 = Test2.new()
	var test3 = Test3.new()
	
	test2.test_func()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
