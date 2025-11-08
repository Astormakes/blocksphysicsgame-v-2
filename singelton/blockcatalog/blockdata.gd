class_name Blockdata
extends Resource

@export var id: int
@export var showName: String
@export var path: String
@export var mesh: String
@export var shape: String
@export var material: String
@export var colormat: Color
@export var type: String
@export var hpmax: int
@export var cost: float
@export var mass: float
@export var size: Vector3
@export var flows:int
@export var volume: float
@export var flowsSecondary: int

func _init(
	_id: int = -1,
	_showName: String = "",
	_path: String = "",
	_mesh: String = "",
	_shape: String = "",
	_material: String = "",
	_colormat: Color = Color(1, 1, 1),
	_type: String = "Block",
	_cost: float = 0.0,
	_mass: float = 1.0,
	_hpmax: int = 100,
	_size: Vector3 = Vector3(0.2, 0.2, 0.2),
	_flows: int = 0b000100, # only 8 bits!
	_volume: float = 0.0,
	_flowssec: int = 0 # only 8 bits!

) -> void:
	id = _id
	showName = _showName
	path = _path
	mesh = _mesh
	shape = _shape
	material = _material
	colormat = _colormat
	type = _type
	cost = _cost
	mass = _mass
	hpmax = _hpmax
	size = _size
	flows = _flows
	flowsSecondary = _flowssec
	volume = _volume
