extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var grid:Dictionary

var creator = 0

@export var frozen: bool = false

var body = self

func _ready():
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

func action5_released(_pos,_normal,_id,_item): ## on T Press... 
	body.freeze = !body.freeze

func mouse1_released(pos,normal:Vector3,id,item):
	pos = (body.to_local(pos+normal/10)*5).snapped(Vector3.ONE)
	$debugg.transform.origin = Vector3(pos)/5
	id = int(id)
	rpc("placeBlock",item,pos,0)
	
func mouse2_released(pos,normal:Vector3,id,item):
	pos = (body.to_local(pos-normal/10)*5).snapped(Vector3.ONE)
	$debugg.transform.origin = Vector3(pos)/5
	id = int(id)
	body.mass -= Blockcatalog.getb(item).mass
	rpc("removeBlock",pos)

func request_dic():
	rpc_id(1,"send_dic",multiplayer.get_unique_id(),"all")

@rpc("any_peer","call_local")
func send_dic(id,type):
	if multiplayer.is_server():
		if type == "all":
			var data = serialize_dic(grid) #i think this needs to be Serialized.... right now its not crashing but also not working
			rpc_id(id,"recieve_dic",data,type)

@rpc("authority","call_remote","reliable")
func recieve_dic(data:Dictionary,type):
	if not multiplayer.is_server():
		if type == "all":
			for x in data:
				var out = data[x]
				grid[x] = Block.new(body,out.pos,out.rot,out.id,out.hp,out.temp)
			for x in grid.keys():
				grid[x].update()


@rpc("any_peer","call_local","reliable")
func placeBlock(id: int,pos: Vector3i,rot:int):
	if not grid.has(pos):
		var block = Block.new(body,pos,rot,id)
		grid.set(pos,block)
		body.mass += Blockcatalog.getb(id).mass 

@rpc("any_peer","call_local","reliable")
func removeBlock(pos:Vector3i):
	if grid.has(pos):
		body.mass -= Blockcatalog.getb(grid[pos].id).mass 
		grid[pos].destroy()
		if grid.size() < 1:
			print("grid "+ name + "que free")
			self.queue_free()
	else:
		print("ERROR: Block not found in grid Directory")
		print(grid)
func serialize_dic(dic:Dictionary):
	var output:Dictionary 
	for x in dic.keys():
		output[x] = dic[x].get_properties()
	return output
