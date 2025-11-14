extends Node3D

@onready var ray:RayCast3D = RayCast3D.new()

var action
var action2

@onready var camera = $Camera3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_multiplayer_authority():
		$Camera3D.current = true
	else:
		$Camera3D.current = false
	
	ray.debug_shape_thickness = 1
	add_child(ray)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var mouse_pos = get_viewport().get_mouse_position()
	ray.target_position = to_local(camera.project_ray_normal(mouse_pos)*2 + camera.project_ray_origin(mouse_pos))

func _input(_event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if not camera.current: return
	
	action = "mouse1"
	action2 = "_pressed"
	if Input.is_action_just_pressed(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,$"../..".name)

	action = "mouse1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,$"../..".name)
