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
var itemrotation:int = 0

func _ready() -> void:
	if is_multiplayer_authority():
		$Camera3D.current = true
		lable.text = str(item) + " " + ItemCatalog.geti(item).showName
		
	ray.debug_shape_thickness = 1
	add_child(ray)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority(): return
	if not camera.current: 
		lable.text = ""
		return
	
	var currentitem = ItemCatalog.geti(item)
	var displaytext = str(Engine.get_frames_per_second()) + "\n"
	var obj = ray.get_collider()

	fps.text = displaytext
	
	var mouse_pos = get_viewport().get_mouse_position()
	ray.target_position = to_local(camera.project_ray_normal(mouse_pos)*2 + camera.project_ray_origin(mouse_pos))

	if currentitem.type == "block" or currentitem.type == "shape":
		if obj:
			if "looking_at" in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred("looking_at",objpos,objnormal,player.name,item,itemrotation)

func _input(_event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if not camera.current: 
		lable.text = ""
		return
	
	if Input.is_action_just_released("mousewheel_up"):
		item = clamp(item+1,0,ItemCatalog.size()-1)
		if ItemCatalog.geti(item):
			lable.text = str(item) + " " + ItemCatalog.geti(item).showName
		
	if Input.is_action_just_released("mousewheel_down"):
		item = clamp(item-1,0,ItemCatalog.size()-1)
		if ItemCatalog.geti(item):
			lable.text = str(item) + " " + ItemCatalog.geti(item).showName
	
	if Input.is_action_just_pressed("rotateblocksimple"):
		itemrotation += 1
		if itemrotation == 24: itemrotation = 0
	
	action = "mouse1"
	action2 = "_pressed"
	if Input.is_action_just_pressed(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item,itemrotation)
	
	action = "mouse1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item,itemrotation)
		
	action = "mouse2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item,itemrotation)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item,itemrotation)

	action = "action1"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action2"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action3"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action4"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action = "action5"
	action2 = "_released"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
	
	action2 = "_pressed"
	if Input.is_action_just_released(action):
		var obj = ray.get_collider()
		if obj:
			if (action+action2) in obj:
				var objpos = ray.get_collision_point()
				var objnormal = ray.get_collision_normal()
				obj.call_deferred(action+action2,objpos,objnormal,player.name,item)
