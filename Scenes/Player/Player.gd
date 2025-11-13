extends Node

var speed := 1
var mouseSpeed = 0.15
var runMul = 5
var movementDamping = Vector3(30,1,30)

var noclip = false

@onready var Head = $Body/Head
@onready var body = $Body

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	body.freeze = noclip

func _process(_delta: float) -> void:
	if is_multiplayer_authority():
		movement(_delta)

### movement simple rn ... 
func movement(_delta) -> void:
	if Input.is_action_just_pressed("Noclip"):
		noclip = not noclip
		body.freeze = noclip
	var velocity:Vector3 = Vector3(0,0,0)
	
	if Input.is_action_pressed('Forward'):
			velocity.z = -speed
	if Input.is_action_pressed('Left'):
			velocity.x = -speed
	if Input.is_action_pressed('Backward'):
			velocity.z = speed
	if Input.is_action_pressed('Right'):
			velocity.x = speed
	if Input.is_action_pressed("jump"):
			velocity.y = 3
	if Input.is_action_pressed("Sneak"):
		velocity.y = -3
		
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("Run"):
		velocity = velocity * runMul
		
	
	
	if noclip:
		body.transform.origin += Head.basis * velocity
	else:
		var head_rotation = Head.global_transform.basis.get_euler()
		var yaw_only_basis = Basis(Vector3.UP, head_rotation.y)  # Only yaw
		body.apply_central_force((yaw_only_basis * 2 * velocity / _delta) - body.linear_velocity*movementDamping)

		print(((yaw_only_basis * 2 * velocity / _delta) - body.linear_velocity*movementDamping))

### head rotation
func _input(event):
	if not is_multiplayer_authority(): return
	if not Input.is_action_pressed("Alt"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if event is InputEventMouseMotion:
			Head.rotation_degrees.x = clamp(Head.rotation_degrees.x - event.relative.y * mouseSpeed,-89,89) # this rotates the players head
			Head.rotation_degrees.y = Head.rotation_degrees.y - event.relative.x * mouseSpeed # this rotates the players head
			
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # this is what uncatches the mouse to close the game using alt key for example
