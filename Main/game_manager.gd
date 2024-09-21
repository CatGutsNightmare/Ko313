extends Node



func host_game():
	print("Become host pressed")
	MultiplayerManager.host_game()

func join_game():
	print("Join game pressed")
	MultiplayerManager.join_game()

func list_steam_lobbies():
	print("List Steam Lobbies")
