extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"

func host_game():
	print("Starting host!")
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_delete_player_from_game)

func join_game():
	print("Joining!")
	
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client_peer

func _add_player_to_game(id: int):
	print("Player %s joined the game!" % id)

func _delete_player_from_game(id: int):
	print("Player %s left the game!" % id)
