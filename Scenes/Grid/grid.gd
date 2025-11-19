extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var blockDic:Dictionary[Vector3i,Block]

@export var frozen: bool = false

var body

func _ready():
	body = RigidBody3D.new()
	add_child(body)
	body.freeze = frozen

	var test_layout := [
	{"id": 0, "pos": Vector3i(0, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(1, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 1, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 0, 1), "rot": 0},
	{"id": 0, "pos": Vector3i(-1, 0, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, -1, 0), "rot": 0},
	{"id": 0, "pos": Vector3i(0, 0, -1), "rot": 0}]
	
	
	for x in test_layout: 
		placeBlock(x.id,x.pos,x.rot)
	
	removeBlock(Vector3i(0, 1, 0))


func placeBlock(id: int,pos: Vector3i,rot:int):
	blockDic[pos] = Block.new(id,pos,rot,body)
	body.mass += Blockcatalog.getb(id).mass 

func removeBlock(pos:Vector3i):
	blockDic[pos].destroy()
