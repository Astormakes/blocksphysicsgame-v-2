extends Control

@onready var Adressfied = $TextEdit


func _on_host_pressed() -> void:
	
	Server.create_game()
	queue_free()

func _on_join_pressed() -> void:
	Server.join_game(Adressfied.text)
	queue_free()
