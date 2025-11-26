class_name Itemdata
extends Resource

@export var showName: String
@export var path: String
@export var type: String
@export var blockid:int

func _init(
	_showName: String = "",
	_path: String = "",
	_type: String = ""

) -> void:
	showName = _showName
	path = _path
	type = _type
