extends Node


const PACKET_READ_LIMIT: int = 32

var is_host: bool = false
var lobby_id: int = 0
var lobby_members: Array = []
var lobby_members_max: int = 4

func create_lobby():
	if lobby_id == 0:
		Steam.createLobby(Steam.LOBBY_TYPE_PUBLIC,lobby_members_max)

func _on_lobby_created(connect: int, this_lobby_id: int):
	if connect == 1:
		lobby_id = this_lobby_id
		Steam.setLobbyJoinable(lobby_id, true)
		
		Steam.setLobbyData(lobby_id, "name" , "Michael's Lobby")
