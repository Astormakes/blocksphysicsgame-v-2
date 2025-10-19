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
@export var hpmax: float
@export var cost: float
@export var mass: float
@export var size: Vector3
@export var flows: PackedVector3Array
@export var volume: float
@export var flowsSecondary: PackedVector3Array

@export var hpcur: float
@export var color: Color
@export var pos: float

func _init(
	_id: int = -1, # -1 to prevent colisions if none is set.
	_showName: String = "",
	_path: String = "",
	_mesh: String = "",
	_shape: String = "",
	_material: String = "",
	_colormat: Color = Color(1,1,1),
	_type: String = "Block",
	_cost: float = 0,
	_mass: float = 1.0,
	_hpmax: float = 100.0,
	_size: Vector3 = Vector3(0.2,0.2,0.2),
	_flows: PackedVector3Array = [],
	_volume: float = 0.0,
	_flowssec: PackedVector3Array = []

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
	volume = _volume
	flowsSecondary = _flowssec


	# Automatically set derived or default values
	hpcur = hpmax
	color = colormat
