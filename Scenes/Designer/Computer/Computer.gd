extends StaticBody3D

@export var DesignerCameraPackage:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@rpc("any_peer","call_local","reliable")
func mouse1_pressed(pos,normal,id):
	print("m1_pressed:",pos, " normal:",normal," id:",id)

func mouse1_released(pos,normal,id):
	Spawn_DesingerCam(1)
	print("m1_released:",pos, " normal:",normal," id:",id)

@rpc("authority","call_remote","reliable")
func Spawn_DesingerCam(id) -> void:
	print("new Player ", id)
	if multiplayer.is_server():
		var DesingerCam:Node = DesignerCameraPackage.instantiate()
		DesingerCam.name = str(id)
		DesingerCam.transform.origin = transform.origin
		
		$"../DesignerCameraSpawner".call_deferred("add_child",DesingerCam)
