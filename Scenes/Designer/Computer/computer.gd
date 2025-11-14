extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_instance_id())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func mouse1_press(pos,normal,id):
	print("clicked by:",id, " at:", pos, "with normal:",normal)
