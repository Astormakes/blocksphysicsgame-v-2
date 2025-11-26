extends Node

var speed = 75
var mouseSpeed = 0.15
var runMul = 2
var coruchMul = 0.5

var accel_ground = 6000000
var accel_air = 20
var decel_ground = 1200000000
var decel_air = 5

var focus = false
var noclip = false

@onready var shapecast:ShapeCast3D = $Body/ShapeCast3D
@onready var head:Node3D = $Body/Head
@onready var body = $Body
@onready var camera:Camera3D = $Body/Head/Camera3D


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _ready() -> void:
	body.contact_monitor = true
	body.max_contacts_reported = 4
	body.freeze = noclip
	body.linear_damp = 0

	# Disable player friction to not stick at block/walls
	if body.physics_material_override == null:
		body.physics_material_override = PhysicsMaterial.new()
		body.physics_material_override.friction = 0.25
		body.physics_material_override.rough = false


	if is_multiplayer_authority():
		camera.current = true
		Server.localplayer = self


func currentCam():
		camera.current = true


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if Input.is_action_just_pressed("debug"):
			currentCam()
		if not camera.current: return
		movement(_delta)


func movement(_delta) -> void:
	if Input.is_action_just_pressed("Noclip"):
		noclip = not noclip
		body.freeze = noclip
		if noclip:
			body.linear_velocity = Vector3(0, 0, 0)


	var velocity:Vector3 = Vector3(0,0,0)

	if Input.is_action_pressed('Forward'):
			velocity.z = -1
	if Input.is_action_pressed('Left'):
			velocity.x = -1
	if Input.is_action_pressed('Backward'):
			velocity.z = 1
	if Input.is_action_pressed('Right'):
			velocity.x = 1

	velocity = velocity.normalized()*speed

	var current_speed = speed


	if Input.is_action_pressed("Sneak"):
		$"Body/BodyColider Standing".disabled = true
		$"Body/BodyColider couching".disabled = false
		head.transform.origin = Vector3(0, 0, 0)
		$Body/MeshInstance3D.transform.origin = Vector3(0, -0.7, 0)
		current_speed *= coruchMul
	else:
		shapecast.force_shapecast_update()
		if not shapecast.is_colliding():
			$"Body/BodyColider Standing".disabled = false
			$"Body/BodyColider couching".disabled = true
			head.transform.origin = Vector3(0, 0.7, 0)
			$Body/MeshInstance3D.transform.origin = Vector3(0, 0, 0)


	if Input.is_action_pressed("Run"):
		current_speed *= runMul
		
	if Input.is_action_just_pressed("jump") and _is_on_floor():
		body.linear_velocity.y = 50.0


	#Movement from Head direction
	var head_rotation = head.global_transform.basis.get_euler()
	var yaw_basis = Basis(Vector3.UP, head_rotation.y)
	
	var dir = yaw_basis * velocity
	dir.y = 0
	if dir.length() > 0:
		dir = dir.normalized()


	if noclip:
		body.transform.origin += head.basis * velocity

	var target_vel = dir * current_speed


	var horiz = Vector3(body.linear_velocity.x, 0, body.linear_velocity.z)
	var target_horiz = Vector3(target_vel.x, 0, target_vel.z)


	var moving_input = target_horiz.length() > 0
	var accel = 0

	if _is_on_floor():
		if moving_input:
			accel = accel_ground
		else:
			accel = decel_ground
	else:
		if moving_input:
			accel = accel_air
		else:
			accel = decel_air

	# horizontal velocity target horizon
	horiz = horiz.move_toward(target_horiz, accel * _delta)
	body.linear_velocity.x = horiz.x
	body.linear_velocity.z = horiz.z


	if not get_window().has_focus():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		focus = true
	else:
		focus = false


func _is_on_floor() -> bool:
	var state = PhysicsServer3D.body_get_direct_state(body.get_rid())
	if state == null:
		return false

	var up = Vector3.UP
	var contact_count = state.get_contact_count()

	for i in range(contact_count):
		var normal = state.get_contact_local_normal(i)
		if normal.dot(up) > 0.6:
			return true
	return false


### head rotation
func _input(event):
	if not is_multiplayer_authority(): return
	if not camera.current: return


	if Input.is_action_pressed("Alt") or focus:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # this is what uncatches the mouse to close the game using alt key for example
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		if event is InputEventMouseMotion:
			head.rotation_degrees.x = clamp(head.rotation_degrees.x - event.relative.y * mouseSpeed,-89,89) # this rotates the players head
			head.rotation_degrees.y = head.rotation_degrees.y - event.relative.x * mouseSpeed # this rotates the players head
