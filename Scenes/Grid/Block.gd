class_name Block
extends RefCounted

var id: int
var hp: int
var temp: float
var pos: Vector3i
var rot: int = 0 # 0–5 for orientation
var colisionshape: CollisionShape3D
var mesh:MeshInstance3D
var parent:Node

func _init(_parent:Node,_pos: Vector3i,_rot:int,_id:int = 1,_hp = null,_temp = 20) -> void:
	id = _id
	if _hp == null:
		hp = Blockcatalog.getb(_id).hpmax
	else:
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
	mesh.name = str(pos)+"_mesh"
	
	colisionshape = CollisionShape3D.new()
	parent.add_child(colisionshape)
	colisionshape.transform.origin = Vector3(pos/5.0)
	var shape = BoxShape3D.new()
	shape.size = Vector3(0.2,0.2,0.2)
	colisionshape.shape = shape
	colisionshape = colisionshape
	colisionshape.name = str(pos)+"_shape"
	

func destroy() -> void:
	print("removed block with pos:", pos)
	if colisionshape:
		colisionshape.free()
	if mesh:
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
	
