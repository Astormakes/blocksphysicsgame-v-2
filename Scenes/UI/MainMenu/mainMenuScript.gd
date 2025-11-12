extends Control

@onready var Adressfied = $TextEdit


func _ready() -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter"):
		_on_join_pressed()


func _on_host_pressed() -> void:
	var world = load("res://Scenes/World/world.tscn").instantiate()
	Server.create_game(world)
	queue_free()

func _on_join_pressed() -> void:
	#GlobalServerHandler._on_join(Adressfied.text)
	queue_free()
