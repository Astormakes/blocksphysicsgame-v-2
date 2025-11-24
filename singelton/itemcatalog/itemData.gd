class_name Itemdata
extends Resource

@export var id: int
@export var showName: String
@export var path: String
@export var type: String
@export var blockid:int

func _init(
	_id: int = -1,
	_showName: String = "",
	_path: String = "",
	_type: String = ""

) -> void:
	id = _id
	showName = _showName
	path = _path
	type = _type
