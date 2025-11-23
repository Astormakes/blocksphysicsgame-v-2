class_name Block
extends RefCounted

var id: int
var hp: int
var temp: float
var pos: Vector3i
var rot: int = 0 # 0–5 for orientation
var colisionshape: CollisionShape3D
var mesh
var parent:Node

func _init(_parent:Node,_pos: Vector3i,_rot:int,_id:int = 1,_hp = Blockcatalog.getb(_id).hpmax,_temp = 20) -> void:
	id = _id
	hp = _hp
	temp = _temp
	pos = _pos
	rot = _rot
	parent = _parent
	update()


func update():
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
	
	parent.grid.erase(pos)

func set_properties(dic):
	id = dic["id"]
	hp = dic["hp"]
	temp = dic["temp"]
	pos = dic["pos"]
	parent = dic["parent"]

func get_properties() -> Dictionary:
	var out:Dictionary = {"id":id,"hp":hp,"temp":temp,"pos":pos,"rot":rot,"parent":mesh}
	return out
	
