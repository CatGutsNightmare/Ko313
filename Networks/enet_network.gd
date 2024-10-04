extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"

var multiplayer_player_scene = preload("res://Player/MultiplayerPlayer.tscn")
var multiplayer_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var _player_spawn_node
var host_mode_enabled = false
var multiplayer_mode_enabled = false



func host_game():
	print("Starting host!")
	
	_player_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	multiplayer_peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_delete_player_from_game)
	
	if not OS.has_feature("dedicated_server"):
			_add_player_to_game(1)

func join_game(lobby_id):
	print("Joining!")
	
	multiplayer_peer.create_client(SERVER_IP, SERVER_PORT)
	multiplayer.multiplayer_peer = multiplayer_peer

func _add_player_to_game(id: int):
	print("Player %s joined the game!" % id)
	
	var player_to_add = multiplayer_player_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_player_spawn_node.add_child(player_to_add, true)

func _delete_player_from_game(id: int):
	print("Player %s left the game!" % id)
	if not _player_spawn_node.has_node(str(id)):
		return
	_player_spawn_node.get_node(str(id)).queue_free()
