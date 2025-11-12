extends Node

const PORT = 65165
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 20

@export var world = "res://Scenes/World/world.tscn"

var players = {}

var players_loaded = 0

var peer:ENetMultiplayerPeer 

func _ready():
	peer = ENetMultiplayerPeer.new()



func create_game():
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		print(error)
		
	multiplayer.multiplayer_peer = peer
	
	get_tree().change_scene_to_file(world)
	print(multiplayer.get_unique_id())


func join_game(address = ""):
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	
	var error = peer.create_client(address, PORT)
	if error:
		print(error)
	multiplayer.multiplayer_peer = peer

	print(multiplayer.get_unique_id())
	get_tree().change_scene_to_file(world)
