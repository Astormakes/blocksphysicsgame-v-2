extends StaticBody3D

@export var DesignerCameraPackage:PackedScene

var designerspawner:MultiplayerSpawner 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	designerspawner = $"../DesignerCameraSpawner"


func mouse1_pressed(_pos,_normal,_id):
	pass

func mouse1_released(_pos,_normal,id):
	rpc_id(1,"Spawn_DesingerCam",id)

@rpc("any_peer","call_local","reliable")
func Spawn_DesingerCam(id) -> void: # spawn designer 
	if multiplayer.is_server():
		var createdesigner = true
		for x in designerspawner.get_children():
			print(x.name)
			if x.name == id:
				createdesigner = false
				break
		if createdesigner:
			var DesingerCam:Node = DesignerCameraPackage.instantiate()
			DesingerCam.name = str(id)

			designerspawner.call_deferred("add_child",DesingerCam)
