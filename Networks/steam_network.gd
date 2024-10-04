extends Node


var multiplayer_player_scene = preload("res://Player/MultiplayerPlayer.tscn")
var multiplayer_peer: SteamMultiplayerPeer = SteamMultiplayerPeer.new()
var _player_spawn_node

var host_mode_enabled = false
var multiplayer_mode_enabled = false
var _hosted_lobby_id = 0

const LOBBY_NAME = "WHATIDONTKNOW"
const LOBBY_MODE = "CoOP"

func _ready():
	multiplayer_peer.lobby_created.connect(_on_lobby_created)

func host_game():
	print("Starting host!")
	
	_player_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	multiplayer_peer.create_lobby(SteamMultiplayerPeer.LOBBY_TYPE_PUBLIC)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_delete_player_from_game)

	_add_player_to_game(1)

func join_game(lobby_id):
	print("Joining lobby!")
	
	multiplayer_peer.connect_lobby(lobby_id)
	multiplayer.multiplayer_peer = multiplayer_peer

func _on_lobby_created(connection: int, lobby_id):
	print("On lobby created")
	if connection == 1:
		_hosted_lobby_id = lobby_id
		print("Created lobby: %s" % _hosted_lobby_id)
		
		Steam.setLobbyJoinable(_hosted_lobby_id, true)
		
		Steam.setLobbyData(_hosted_lobby_id, "name", LOBBY_NAME)
		Steam.setLobbyData(_hosted_lobby_id, "mode", LOBBY_MODE)

func list_lobbies():
	Steam.addRequestLobbyListDistanceFilter(Steam.LOBBY_DISTANCE_FILTER_WORLDWIDE)
	#Steam.addRequestLobbyListStringFilter("name", "WHATIDONTKNOW", Steam.LOBBY_COMPARISON_EQUAL)
	Steam.requestLobbyList()

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
