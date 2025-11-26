class_name Block
extends RefCounted

var id: int
var hp: int
var temp: float
var pos: Vector3i
var rot: int = 0 # 0–5 for orientation
var colisionshape: CollisionShape3D
var mesh:MeshInstance3D
var parent:Node3D

var rotationVectors = [
Vector3(0, 0, 0),
Vector3(0, 0, 1.57079633),
Vector3(0, 0, 3.14159265),
Vector3(0, 0, 4.71238898),
Vector3(1.57079633, 0, 0),
Vector3(1.57079633, 0, 1.57079633),
Vector3(1.57079633, 0, 3.14159265),
Vector3(1.57079633, 0, 4.71238898),
Vector3(3.14159265, 0, 0),
Vector3(3.14159265, 0, 1.57079633),
Vector3(3.14159265, 0, 3.14159265),
Vector3(3.14159265, 0, 4.71238898),
Vector3(4.71238898, 0, 0),
Vector3(4.71238898, 0, 1.57079633),
Vector3(4.71238898, 0, 3.14159265),
Vector3(4.71238898, 0, 4.71238898),
Vector3(0, 1.57079633, 0),
Vector3(0, 1.57079633, 1.57079633),
Vector3(0, 1.57079633, 3.14159265),
Vector3(0, 1.57079633, 4.71238898),
Vector3(0, 4.71238898, 0),
Vector3(0, 4.71238898, 1.57079633),
Vector3(0, 4.71238898, 3.14159265),
Vector3(0, 4.71238898, 4.71238898)]

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
	var thing:Blockdata = Blockcatalog.getb(id)
	if thing.type == "block":
		mesh = MeshInstance3D.new()
		mesh.transform.origin = Vector3(pos/5.0)
		mesh.mesh = thing.mesh
		parent.add_child(mesh)
		mesh.name = str(pos)+"_mesh"
		
		colisionshape = CollisionShape3D.new()
		parent.add_child(colisionshape)
		colisionshape.transform.origin = Vector3(pos/5.0)
		colisionshape.shape = thing.shape
		colisionshape.name = str(pos)+"_shape"

	if thing.type == "shape":
		mesh = MeshInstance3D.new()
		mesh.transform.origin = Vector3(pos/5.0)
		mesh.mesh = thing.mesh
		parent.add_child(mesh)
		mesh.rotation = rotationVectors[rot]
		mesh.name = str(pos)+"_mesh"
		
		colisionshape = CollisionShape3D.new()
		parent.add_child(colisionshape)
		colisionshape.transform.origin = Vector3(pos/5.0)
		colisionshape.rotation = rotationVectors[rot]
		colisionshape.shape = thing.shape
		colisionshape.name = str(pos)+"_shape"

func destroy() -> void:
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
	return {"itemid":id,"hp":hp,"temp":temp,"pos":pos,"rot":rot,"parent":mesh}
	
