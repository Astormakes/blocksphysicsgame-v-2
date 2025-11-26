extends Node

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
		"Hands",
		"",
		""
	))

	items.insert(1,Itemdata.new(
		"Metalblock",
		"",
		"block"
	))
	items[1].blockid = 0

	items.insert(2,Itemdata.new(
		"Metalslope 1x1x1",
		"",
		"shape"
	))
	items[2].blockid = 4

	items.insert(3,Itemdata.new(
		"Metalslope 1x1x2",
		"",
		"shape"
	))
	items[3].blockid = 7
