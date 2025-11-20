extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var blockDic:Dictionary[Vector3i,Block]

@export var frozen: bool = false

var body

func _ready():
	body = RigidBody3D.new()
	add_child(body)
	body.freeze = frozen
	print(multiplayer.get_unique_id(),": grid:",name, "created")
	

	if multiplayer.is_server(): ### initilize testdata
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
	else:
		request_dic()

func request_dic():
	rpc_id(1,"send_dic",multiplayer.get_unique_id(),"all")

@rpc("any_peer","call_local")
func send_dic(id,type):
	if multiplayer.is_server():
		print(id," requested grid ",type)
		if type == "all":
			var data = blockDic # i think this needs to be Serialized.... right now its not crashing but also not working
			rpc_id(id,"recieve_dic",data,type)

@rpc("authority","call_remote","reliable")
func recieve_dic(data:Dictionary[Vector3i,Block],type):
	if not multiplayer.is_server():
		print(multiplayer.get_unique_id()," revieced grid ",type)
		if type == "all":
			blockDic = data
			print(multiplayer.get_unique_id()," recieved:",data)
			for x in blockDic.keys():
				blockDic[x].update()


func placeBlock(id: int,pos: Vector3i,rot:int):
	blockDic[pos] = Block.new(id,pos,rot,body)
	body.mass += Blockcatalog.getb(id).mass 

func removeBlock(pos:Vector3i):
	blockDic[pos].destroy()
