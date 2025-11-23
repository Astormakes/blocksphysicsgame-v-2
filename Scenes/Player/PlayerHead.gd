extends Node3D

@onready var ray:RayCast3D = RayCast3D.new()

var action
var action2

@onready var player:Node3D = $"../.."
@onready var lable = $Control/Label
@onready var fps = $"Control/fps counter"

@onready var camera = $Camera3D
# Called when the node enters the scene tree for the first time.

var item:int

func _ready() -> void:
	if is_multiplayer_authority():
		$Camera3D.current = true
		lable.text = str(item) + " " + ItemCatalog.geti(item).showName
		
	ray.debug_shape_thickness = 1
	add_child(ray)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var displaytext = str(Engine.get_frames_per_second()) + "\n"
	
	fps.text = displaytext
	
	var mouse_pos = get_viewport().get_mouse_position()
	ray.target_position = to_local(camera.project_ray_normal(mouse_pos)*2 + camera.project_ray_origin(mouse_pos))

func _input(_event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if not camera.current: return
	
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
	
	action = "mouse1"
	action2 = "_pressed"
	if Input.is_action_just_pressed(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "mouse1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
		
	action = "mouse2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)

	action = "action1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action3"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action4"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action5"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.global_position
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
