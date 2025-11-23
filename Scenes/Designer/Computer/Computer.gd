extends StaticBody3D

@export var DesignerCameraPackage:PackedScene
@export var gridPackage:PackedScene

@onready var designerspawner:MultiplayerSpawner = $"../DesignerCameraSpawner"
@onready var gridspawner:MultiplayerSpawner = $"../GridSpawner"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func mouse1_released(pos,normal,id):
	rpc_id(1,"Spawn_DesingerCam",id)
	print("m1_released:",pos, " normal:",normal," id:",id)

func action5_released(_pos,_normal,id): ## on T Press... 
	rpc_id(1,"spawn_grid",id)

@rpc("any_peer","call_local","reliable")
func spawn_grid(id):
	if multiplayer.is_server():
		var grid:Node3D = gridPackage.instantiate()
		grid.name = "grid"+id+"_"+str(randi_range(0,9999))
		gridspawner.call_deferred("add_child",grid,true)
		grid.transform.origin = get_parent().transform.origin + Vector3(0,2,-1)
		grid.frozen = true

@rpc("any_peer","call_local","reliable")
func Spawn_DesingerCam(id) -> void: # spawn designer pivot
	if multiplayer.is_server():
		var createdesigner = true
		for x in designerspawner.get_children():
			print(x.name)
			if x.name == id:
				createdesigner = false
				print("designer allready exists ", id)
				break
		if createdesigner:
			print("new designer ", id)
			var DesingerCam:Node3D = DesignerCameraPackage.instantiate()
			DesingerCam.name = id
			designerspawner.call_deferred("add_child",DesingerCam)
			DesingerCam.transform.origin = get_parent().transform.origin + Vector3(0,2,0)
