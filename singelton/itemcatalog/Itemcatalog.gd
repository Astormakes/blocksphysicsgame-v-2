extends Node

# id: int
# showName: String
# path: String
# type: String

@export var items:Array

const up = Vector3.UP
const down = Vector3.DOWN
const left = Vector3.LEFT
const right = Vector3.RIGHT
const forward = Vector3.FORWARD
const back = Vector3.BACK

func _ready() -> void:
	defaultitemlist()

func seti(id: int, data: Itemdata) -> void:
	items[id] = data

func geti(id: int) -> Itemdata:
	if items.size() > id:
		return items[id]
	else:
		print("ERROR - Item was requested of Itemcatalog that dosent exist!")
		return null

func size() -> int:
	return items.size()

func defaultitemlist(): 
	items.insert(0,Itemdata.new(
		0,
		"Hands",
		"",
		""
	))

	items.insert(1,Itemdata.new(
		1,
		"Metalblock",
		"",
		"Block"
	))
	items[1].blockid = 0
