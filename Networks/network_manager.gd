extends Node

enum MULTIPLAYER_NETWORK_TYPE { ENET, STEAM }

@export var _players_spawn_node: Node2D

var active_network_type: MULTIPLAYER_NETWORK_TYPE = MULTIPLAYER_NETWORK_TYPE.STEAM
var enet_network_scene := preload("res://Networks/enet_network.tscn")
var steam_network_scene := preload("res://Networks/steam_network.tscn")
var active_network

func _ready() -> void:
	_build_multiplayer_network()

func _build_multiplayer_network():
	if not active_network:
		print("Setting active_network")
		#TODO multiplayer mode enabled
		
		MultiplayerManager.multiplayer_mode_enabled = true 
		
		match active_network_type:
			MULTIPLAYER_NETWORK_TYPE.ENET:
				print("Setting network type to ENet")
				_set_active_network(enet_network_scene)
			MULTIPLAYER_NETWORK_TYPE.STEAM:
				print("Setting network type to Steam")
				_set_active_network(steam_network_scene)
			_:
				print("No match for network type!")

func _set_active_network(active_network_scene):
	var network_scene_initialized = active_network_scene.instantiate()
	active_network = network_scene_initialized
	active_network._player_spawn_node = _players_spawn_node
	add_child(active_network)
	
func host_game(is_dedicated_server = false):
	_build_multiplayer_network()
	MultiplayerManager.host_mode_enabled = true if is_dedicated_server == false else false
	active_network.host_game()

func join_as_client(lobby_id = 0):
	print("joining as client")
	_build_multiplayer_network()
	active_network.join_game(lobby_id)

func list_lobbies():
	_build_multiplayer_network()
	active_network.list_lobbies()
	print(str(active_network))