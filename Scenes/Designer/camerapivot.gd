extends Node3D

@export var move_speed := 0.1
@export var fast_speed := 100.0
@export var look_sensitivity := 0.15
@export var smoothing := 10.0

@onready var camera: Camera3D = $Camera3D

var velocity := Vector3.ZERO
var yaw := 0.0
var pitch := 0.0

var ray:RayCast3D = RayCast3D.new()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _ready():
	
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ray.debug_shape_thickness = 1
	add_child(ray)
	if int(name) == multiplayer.get_unique_id():
		transform.origin = get_parent().get_parent().transform.origin + Vector3(0,2,0)
		$Camera3D.current = true
	else:
		$Camera3D.current = false
	
func _process(_delta: float) -> void:
	if not is_multiplayer_authority(): return
	
	if Input.is_action_just_pressed("escape"):
		queue_free()
		
	var input_dir = Vector3.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	ray.target_position = to_local(camera.project_ray_normal(mouse_pos)*100 + camera.project_ray_origin(mouse_pos))

	var action = "mouse1"
	var action2 = "_pressed"
	if Input.is_action_just_pressed(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name)

	action = "mouse1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name)

	var speed_mod = 1
		
	if Input.is_action_pressed("Forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("Backward"):
		input_dir.z += 1
	if Input.is_action_pressed("Left"):
		input_dir.x -= 1
	if Input.is_action_pressed("Right"):
		input_dir.x += 1
	if Input.is_action_pressed("jump"):
		input_dir.y += 1
	if Input.is_action_pressed("Run"):
		speed_mod = 2
	if Input.is_action_pressed("Sneak"):
		speed_mod = 0.1
		

	transform.origin += basis * input_dir * move_speed * speed_mod

	

func _input(event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("mouse3"):
			yaw -= event.relative.x * look_sensitivity
			pitch -= event.relative.y * look_sensitivity
			pitch = clamp(pitch, -89, 89)
			rotation_degrees = Vector3(pitch, yaw, 0)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
