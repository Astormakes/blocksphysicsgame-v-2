extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var grid:Dictionary

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
			var data = serialize_dic(grid) #i think this needs to be Serialized.... right now its not crashing but also not working
			rpc_id(id,"recieve_dic",data,type)

@rpc("authority","call_remote","reliable")
func recieve_dic(data:Dictionary,type):
	if not multiplayer.is_server():
		print(multiplayer.get_unique_id()," revieced grid ",type)
		if type == "all":
			for x in data:
				var out = data[x]
				grid[x] = Block.new(body,out.pos,out.rot,out.id,out.hp,out.temp)
			for x in grid.keys():
				grid[x].update()


func placeBlock(id: int,pos: Vector3i,rot:int):
	grid[pos] = Block.new(body,pos,rot,id)
	body.mass += Blockcatalog.getb(id).mass 

func removeBlock(pos:Vector3i):
	grid[pos].destroy()

func serialize_dic(dic:Dictionary):
	var output:Dictionary 
	for x in dic.keys():
		output[x] = dic[x].get_properties()
	return output
