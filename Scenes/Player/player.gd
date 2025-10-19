extends Node3D

@export var move_speed := 0.1
@export var fast_speed := 100.0
@export var look_sensitivity := 0.15
@export var smoothing := 10.0

@onready var camera: Camera3D = $Camera3D

var velocity := Vector3.ZERO
var yaw := 0.0
var pitch := 0.0
var target_position := Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	target_position = global_position


func _process(_delta: float) -> void:
	var input_dir = Vector3.ZERO
	
	#if Input.is_action_pressed("mouse2"): # this is so, that the mouse can obly be 
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
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("mouse3"):
			yaw -= event.relative.x * look_sensitivity
			pitch -= event.relative.y * look_sensitivity
			pitch = clamp(pitch, -89, 89)
			rotation_degrees = Vector3(pitch, yaw, 0)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
