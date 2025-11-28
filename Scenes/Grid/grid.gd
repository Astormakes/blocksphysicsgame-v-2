extends Node3D

const BLOCK_SIZE: float = 0.2 # 20 cm

var grid:Dictionary

var creator = 0
var ghostitem = 0
var lookedat
@onready var ghost = $ghost

var minpos = Vector3i.ZERO
var maxpos = Vector3i.ZERO

var gridmax:Vector3i
@export var frozen: bool = false

var body = self

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

func _ready():
	body.freeze = frozen
	print(multiplayer.get_unique_id(),": grid:",name, "created")
	

	if multiplayer.is_server(): ### initilize testdata
		var test_layout := [
		{"itemid": 1,"pos": Vector3i(0, 0, 0), "rot": 0},
		{"itemid": 1,"pos": Vector3i(1, 0, 0), "rot": 0},
		{"itemid": 1,"pos": Vector3i(0, 0, 1), "rot": 0},
		{"itemid": 1,"pos": Vector3i(-1, 0, 0), "rot": 0},
		{"itemid": 1,"pos": Vector3i(0, -1, 0), "rot": 0},
		{"itemid": 1,"pos": Vector3i(0, 0, -1), "rot": 0},
		{"itemid": 2,"pos": Vector3i(1, 1, 0), "rot": 0},
		{"itemid": 2,"pos": Vector3i(-1, 1, 0), "rot": 1},
		{"itemid": 2,"pos": Vector3i(-1, -1, 0), "rot": 2},
		{"itemid": 2,"pos": Vector3i(1, -1, 0), "rot": 3},
		{"itemid": 2,"pos": Vector3i(0, 1, 1), "rot": 17},
		{"itemid": 2,"pos": Vector3i(0, -1, -1), "rot": 19},
		{"itemid": 2,"pos": Vector3i(0, -1, 1), "rot": 23},
		{"itemid": 2,"pos": Vector3i(0, 1, -1), "rot": 16},
		{"itemid": 1,"pos": Vector3i(0, 1, 0), "rot": 0},
		
		]
		
		for x in test_layout: 
			request_placement(body.to_global(x.pos/5.01),Vector3.ZERO,1,x.itemid,x.rot)
		
		#request_removal(body.to_global(Vector3(0,1,0)/5.01),Vector3.ZERO,1)
		request_removal(body.to_global(Vector3(0,0,0)/5.01),Vector3.ZERO,1)
		#request_removal(body.to_global(Vector3(0,-1,0)/5.01),Vector3.ZERO,1)
		body.mass -= 1 
	else:
		request_dic()


func _physics_process(_delta: float) -> void:
	#var speed = 2 * gridmax.x * gridmax.y + 2 * gridmax.x * gridmax.z + 2 * gridmax.z * gridmax.y
	gridmax = Vector3i(2,5,3)
	#var speed = gridmax.x * gridmax.y * gridmax.z
	if lookedat:
		lookedat = false
		ghost.show()
	else:
		ghost.hide()

func action5_released(_pos,_normal,id,_item): ## on T Press... 
	rpc("set_freeze",!body.freeze,int(id))
	print_grid()

## placing blocks
func mouse1_released(pos,normal:Vector3,id,itemid,itemrotation):
	rpc("request_placement",pos,normal,id,itemid,itemrotation)


@rpc("any_peer","call_local","reliable")
func request_placement(pos,normal:Vector3,_id,itemid,itemrotation):
	pos = (body.to_local(pos+normal/10)*5).snapped(Vector3.ONE) # pos to local
	normal = (body.to_local(pos + normal) - body.to_local(pos)).normalized() # normal to local
	placeBlock(ItemCatalog.geti(itemid).blockid,pos,normal,itemrotation)


## removing blocks
func mouse2_released(pos,normal:Vector3,id,_itemid,_itemrotation):
	rpc("request_removal",pos,normal,id) 


@rpc("any_peer","call_local","reliable")
func request_removal(pos,normal,_id):
	pos = (body.to_local(pos-normal/500)*5).snapped(Vector3.ONE) # pos to local - with Minus so its the block itself.
	removeBlock(pos)


func looking_at(pos,normal:Vector3,_id,itemid,itemrotation):
	pos = (body.to_local(pos+normal/10)*5).snapped(Vector3.ONE) # pos to local
	normal = (body.to_local(pos + normal) - body.to_local(pos)).normalized() # normal to local
	lookedat = true
	
	var block = Blockcatalog.getb(ItemCatalog.geti(itemid).blockid)
	var rotatedsize = Basis.from_euler(rotationVectors[itemrotation]) * block.size * normal
	var lenght = max((rotatedsize).distance_to(abs(normal)*100)-100,1)-1 # this is a little boneheaded but it works... 
	# it will basically take the rotated and for normal selected size and litteraly mesure it.
	# im certain there is a better way but this works for now. # this will be reused for placing blocks too.
	
	pos = Vector3(pos+normal*lenght)
	ghost.transform.origin = Vector3(pos)/5
	if ghostitem != itemid:
		ghostitem = itemid+itemrotation
		ghost.mesh = block.mesh
	ghost.rotation = rotationVectors[itemrotation]


func request_dic():
	rpc_id(1,"send_dic",multiplayer.get_unique_id(),"all")


@rpc("any_peer","call_local","reliable")
func set_freeze(state:bool,_id:int):
	body.freeze = state


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
				grid[x] = Block.new(body,out.pos,out.rot,out.itemid,out.hp,out.temp)
				body.mass += Blockcatalog.getb(out.itemid).mass
			body.mass -= 1 

func compareVectors(veca,vecb) -> bool:
	if veca.x > vecb.x or veca.y > vecb.y or veca.z > vecb.z:
		return true
	else:
		return false

func placeBlock(id: int,pos: Vector3,normal:Vector3,rot:int):
	if not grid.has(pos):
		var block = Blockcatalog.getb(id)
		if block.size == Vector3.ONE:
			var gridblock = Block.new(body,pos,rot,id)
			grid.set(Vector3i(pos),gridblock)
			body.mass += block.mass 
			
		else:
			var rotatedsize = Basis.from_euler(rotationVectors[rot]) * block.size * normal
			var lenght = max((rotatedsize).distance_to(abs(normal)*100)-100,1)-1
			pos = Vector3i(pos+normal*lenght)
			
			var size =  block.size
			var rotaedbasis = Basis.from_euler(rotationVectors[rot])
			var placepositions:Array
			for x in range(size.x):
				for y in range(size.y):
					for z in range(size.z):
						# rotate offset positions from size to point in the actual direction the slope is pointing
						var posoffset = Vector3i((rotaedbasis*Vector3(x,y,z)) + pos)
						placepositions.append(posoffset)
						if grid.has(posoffset): 
							print("block blocked.")
							return
							
			body.mass += block.mass
			# if non of the blocks was occupied allready
			var gridblock = Block.new(body,pos,rot,id)
			for x in placepositions:
				gridblock.positions.append(x)
				grid.set(Vector3i(x),gridblock)


func removeBlock(pos:Vector3i):
	if grid.has(pos):
		var mass = Blockcatalog.getb(grid[pos].id).mass 
		grid[pos].destroy()
		if grid.is_empty():
			self.queue_free()
		else:
			body.mass -= mass
	else:
		print("ERROR: Block not found in grid Directory")


func print_grid():
	print(serialize_dic(grid))


func serialize_dic(dic:Dictionary):
	var output:Dictionary 
	for x in dic.keys():
		output[x] = dic[x].get_properties()
	return output
