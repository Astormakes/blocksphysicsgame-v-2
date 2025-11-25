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
			placeBlock(x.id,x.pos)
		removeBlock(Vector3i(0, 1, 0))
		body.mass -= 1 
	else:
		request_dic()

func action5_released(_pos,_normal,_id,_item): ## on T Press... 
	rpc("set_freeze",!body.freeze)


func mouse1_released(pos,normal:Vector3,id,itemid):
	rpc("request_placement",pos,normal,id,itemid)

@rpc("any_peer","call_local","reliable")
func request_placement(pos,normal:Vector3,id,itemid):
	pos = Vector3i((body.to_local(pos+normal/10)*5).snapped(Vector3.ONE))
	var item = ItemCatalog.geti(itemid)
	if item.type == "block":
		$debugg.transform.origin = Vector3(pos)/5
		id = int(id)
		placeBlock(item.blockid,pos)


func mouse2_released(pos,normal:Vector3,id,_itemid):
	rpc("request_removal",pos,normal,id)

@rpc("any_peer","call_local","reliable")
func request_removal(pos,normal,id):
	pos = Vector3i((body.to_local(pos-normal/10)*5).snapped(Vector3.ONE))
	print("removing block at:",pos)
	var block = Blockcatalog.getb(grid[pos].id)
	if block.type == "block":
		$debugg.transform.origin = Vector3(pos)/5
		removeBlock(pos)

func request_dic():
	rpc_id(1,"send_dic",multiplayer.get_unique_id(),"all")

@rpc("any_peer","call_local","reliable")
func set_freeze(state:bool):
	body.freeze = state
	print(multiplayer.get_unique_id(), " freeze Status is ", body.freeze)

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
			grid.clear()
			for x in data:
				var out = data[x]
				grid[x] = Block.new(body,out.pos,out.rot,out.id,out.hp,out.temp)
				body.mass += Blockcatalog.getb(out.id).mass
			body.mass -= 1 



func placeBlock(id: int,pos: Vector3i):
	if not grid.has(pos):
		var block = Block.new(body,pos,0,id)
		grid.set(pos,block)
		body.mass += Blockcatalog.getb(id).mass 
		
func removeBlock(pos:Vector3i):
	if grid.has(pos):
		body.mass -= Blockcatalog.getb(grid[pos].id).mass 
		grid[pos].destroy()
		if grid.size() < 1:
			print("grid "+ name + " que free")
			self.queue_free()
	else:
		print("ERROR: Block not found in grid Directory")

func serialize_dic(dic:Dictionary):
	var output:Dictionary 
	for x in dic.keys():
		output[x] = dic[x].get_properties()
	return output
