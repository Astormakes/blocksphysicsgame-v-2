class_name Block
extends RefCounted

var id: int
var hp: float
var temp: float
var pos: Vector3i
var rot: int = 0 # 0–5 for orientation
var custom_data: Dictionary = {}
var colisionshape: CollisionShape3D


func _init(_id:int,_pos: Vector3i,_rot:int) -> void:
	id = _id
	hp = Blockcatalog.getb(_id).hpmax
	temp = 20
	pos = _pos
	rot = _rot
