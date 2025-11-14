extends Node

var speed = 3
var mouseSpeed = 0.15
var runMul = 2
var movementDamping = Vector3(100,1,100)

var noclip = false

@onready var Head = $Body/Head
@onready var body = $Body
@onready var camera:Camera3D = $Body/Head/Camera3D

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	body.contact_monitor = true
	body.max_contacts_reported = 2
	body.freeze = noclip
	body.linear_damp = 0

func _process(_delta: float) -> void:
	if is_multiplayer_authority():
		if not camera.current: return
		movement(_delta)

### movement simple rn ... 
func movement(_delta) -> void:
	if Input.is_action_just_pressed("Noclip"):
		noclip = not noclip
		body.freeze = noclip
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
	
	if Input.is_action_pressed("Sneak"):
		velocity.y = -3
	if Input.is_action_just_pressed("jump"):
			body.linear_velocity += Vector3(0,5,0)
	
	if Input.is_action_pressed("Run"):
		velocity *= runMul
	
	
	var coliders:Array = body.get_colliding_bodies()
	var dampening:Vector3 =  Vector3.ZERO
	
	var head_rotation = Head.global_transform.basis.get_euler()
	var yaw_only_basis = Basis(Vector3.UP, head_rotation.y)
	
	if coliders.size():
		var colider = coliders[0]
		if "apply_central_force" in colider:
			colider.apply_central_force(yaw_only_basis * -velocity / _delta)
		
		for c in coliders:
			if "linear_velocity" in c:
				dampening += c.linear_velocity / coliders.size()	
		dampening -= body.linear_velocity*movementDamping
	else:
		velocity *= Vector3(0.1,1,0.1) # if not touching anything no change in velocity
	
	if noclip:
		body.transform.origin += Head.basis * velocity
	else:
		body.apply_central_force((yaw_only_basis * velocity / _delta) + dampening)
		
### head rotation
func _input(event):
	if not is_multiplayer_authority(): return
	if not camera.current: return
	
	if not Input.is_action_pressed("Alt"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if event is InputEventMouseMotion:
			Head.rotation_degrees.x = clamp(Head.rotation_degrees.x - event.relative.y * mouseSpeed,-89,89) # this rotates the players head
			Head.rotation_degrees.y = Head.rotation_degrees.y - event.relative.x * mouseSpeed # this rotates the players head
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # this is what uncatches the mouse to close the game using alt key for example
