extends Node3D

@export var move_speed := 0.05
@export var fast_speed := 3.0
@export var slow_speed := 0.2
@export var look_sensitivity := 0.15
@export var smoothing := 10.0

@onready var camera: Camera3D = $Camera3D

@onready var lable = $Camera3D/Control/GrayBackground/Label

var velocity:Vector3 = Vector3.ZERO
var yaw:float = 0.0
var pitch:float = 0.0

var item = 0

var ray:RayCast3D = RayCast3D.new()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

@rpc("any_peer","call_local","reliable")
func free() -> void:
	Server.localplayer.currentCam()
	queue_free()

func _ready():
	ray.debug_shape_thickness = 1
	add_child(ray)
	#transform.origin = get_parent().get_parent().transform.origin + Vector3(0,2,0)
	if is_multiplayer_authority():
		camera.current = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _process(_delta: float) -> void:
	if not is_multiplayer_authority(): return
	
	if Input.is_action_just_pressed("exit"):
		rpc("free")
	
	var input_dir = Vector3.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	ray.target_position = to_local(camera.project_ray_normal(mouse_pos)*100 + camera.project_ray_origin(mouse_pos))
	
	var speed_mod = 1
	
	if Input.is_action_pressed("Forward"):
		input_dir.z -= move_speed
	if Input.is_action_pressed("Backward"):
		input_dir.z += move_speed
	if Input.is_action_pressed("Left"):
		input_dir.x -= move_speed
	if Input.is_action_pressed("Right"):
		input_dir.x += move_speed
	if Input.is_action_pressed("jump"):
		input_dir.y += move_speed
	if Input.is_action_pressed("Run"):
		speed_mod = fast_speed
	if Input.is_action_pressed("Sneak"):
		speed_mod = slow_speed
	
	transform.origin += basis * input_dir * move_speed * speed_mod

func _input(event: InputEvent) -> void: # Key Presses and Looking.
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
	
	if Input.is_action_just_released("mousewheel_up"):
		item = clamp(item+1,0,ItemCatalog.size()-1)
		print(item)
		print(ItemCatalog.geti(item))
		if ItemCatalog.geti(item):
			lable.text = str(item) + " " + ItemCatalog.geti(item).showName
		
	if Input.is_action_just_released("mousewheel_down"):
		item = clamp(item-1,0,ItemCatalog.size()-1)
		print(item)
		print(ItemCatalog.geti(item))
		if ItemCatalog.geti(item):
			lable.text = str(item) + " " + ItemCatalog.geti(item).showName
	
	
	var action = "mouse1"
	var action2 = "_pressed"
	if Input.is_action_just_pressed(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action = "mouse1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
		
	action = "mouse2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)

	action = "action1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action = "action2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action = "action3"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action = "action4"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action = "action5"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,name,item)
