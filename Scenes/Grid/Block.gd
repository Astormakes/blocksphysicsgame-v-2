class_name Block
extends RefCounted

var id: int
var hp: int
var temp: float
var pos: Vector3i
var rot: int = 0 # 0–5 for orientation
var custom_data: Dictionary = {}
var colisionshape: CollisionShape3D
var mesh
var parent:Node

func _init(_id:int,_pos: Vector3i,_rot:int,_parent:Node) -> void:
	id = _id
	hp = Blockcatalog.getb(_id).hpmax
	temp = 20
	pos = _pos
	rot = _rot
	parent = _parent
	_update()


func _update():
	mesh = MeshInstance3D.new()
	mesh.transform.origin = Vector3(pos/5.0)
	mesh.mesh = load(Blockcatalog.getb(id).mesh)
	parent.add_child(mesh)
	
	colisionshape = CollisionShape3D.new()
	colisionshape.transform.origin = Vector3(pos/5.0)
	var shape = BoxShape3D.new()
	shape.size = Vector3(0.2,0.2,0.2)
	colisionshape.shape = shape
	self.colisionshape = colisionshape
	parent.add_child(colisionshape)

func destroy() -> void:
	if colisionshape != null:
		colisionshape.free()
	
	if mesh != null:
		mesh.free()
	
	parent.blockDic.erase(pos)
