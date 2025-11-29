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
	items.insert(items.size(),Itemdata.new(
		"Hands",
		"",
		""
	))

	items.insert(items.size(),Itemdata.new(
		"Metalblock",
		"",
		"block"
	))
	items[items.size()-1].blockid = 0

	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x1",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 1

	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x2",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 2
	
	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x3",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 3
	
	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x4",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 4
	
	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x6",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 5
	
	items.insert(items.size(),Itemdata.new(
		"Metalslope 1x1x8",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 6

	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x1",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 7
	
	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x2",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 8
	
	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x3",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 9
		
	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x4",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 10
	
	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x6",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 11
	
	items.insert(items.size(),Itemdata.new(
		"Metalcorner 1x1x8",
		"",
		"shape"
	))
	items[items.size()-1].blockid = 12
