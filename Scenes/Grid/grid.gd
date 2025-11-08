extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

@export var blockDic:Dictionary

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
	
	removeBlock(Vector3i(0, 1, 0))


func placeBlock(id: int,pos: Vector3i,rot:int):
	blockDic[pos] = Block.new(id,pos,rot,self)

func removeBlock(pos:Vector3i):
	blockDic[pos].destroy()
