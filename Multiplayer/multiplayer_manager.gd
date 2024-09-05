extends Node

const SERVERPOT = 8080
const SERVER_IP = "127.0.0.1"

var multiplayer_player = preload("res://Multiplayer/multiplayer_player.tscn")

var _player_spawn_node

func become_host():
	print("Hosting game!")
	
	_player_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVERPOT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_remove_player_from_game)
	
	_add_player_to_game(1)

func join_game():
	print("Joining game!")
	
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP,SERVERPOT)
	
	multiplayer.multiplayer_peer = client_peer

func _add_player_to_game(id:int):
	print("Player %s joined the game!" % id)
	
	var player_to_add = multiplayer_player.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_player_spawn_node.add_child(player_to_add, true)

func _remove_player_from_game(id:int):
	if _player_spawn_node.has_node(str(id)):
		_player_spawn_node.get_node(str(id)).queue_free()
		print("Player %s left the game!" % id)
