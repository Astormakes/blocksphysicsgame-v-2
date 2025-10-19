extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var blocks:Dictionary
var blockspos:Array

@export var frozen: bool = false

var body

func _ready():
	body = RigidBody3D.new()
	body.freeze = frozen
	add_child(body)
	
	var test_layout := [
	{"id": 0, "pos": Vector3i(0, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(1, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 1, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 0, 1), "rot": 0},
	{"id": 0, "pos": Vector3i(-1, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, -1, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 0, -1), "rot": 0}
	]
	for x in test_layout:
		placeBlock(x.id,x.pos,x.rot)
	pass

func placeBlock(id: int,pos: Vector3i,rot:int):
	blockspos.append(pos)
	blocks[pos] = Block.new(id,pos,rot)
	blockupdate(pos)

func removeBlock():
	pass

func blockupdate(pos: Vector3i) -> void:
	var block = blocks[pos]
	
	var mesh = MeshInstance3D.new()
	mesh.transform.origin = Vector3(pos/5.0)
	mesh.mesh = load(Blockcatalog.getb(block.id).mesh)
	body.add_child(mesh)
	
	var colisionshape = CollisionShape3D.new()
	colisionshape.transform.origin = Vector3(pos/5.0)
	var shape = BoxShape3D.new()
	shape.size = Vector3(0.2,0.2,0.2)
	colisionshape.shape = shape
	block.colisionshape = colisionshape
	body.add_child(colisionshape)
	
