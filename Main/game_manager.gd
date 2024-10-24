extends Node

var lobby_container : Control
var player  = preload("res://Player/Player.tscn")

func _ready() -> void:
		Steam.lobby_match_list.connect(_on_lobby_match_list)

func host_singleplayer():
	var player_to_add = player.instantiate()
	get_node("/root/Main/SubViewport/Players").add_child(player_to_add)

func host_game(type = 0):
	print("Become host pressed")
	if type == 1:
		%NetworkManager.active_network_type = %NetworkManager.MULTIPLAYER_NETWORK_TYPE.STEAM
	else :
		%NetworkManager.active_network_type = %NetworkManager.MULTIPLAYER_NETWORK_TYPE.ENET
	%NetworkManager.become_host()

func join_lobby(lobby_id = 0):
	print("Joining lobby %s" % lobby_id)
	%NetworkManager.join_as_client(lobby_id)

func list_steam_lobbies():
	print("List Steam lobbies")
	%NetworkManager.active_network_type = %NetworkManager.MULTIPLAYER_NETWORK_TYPE.STEAM
	%NetworkManager.list_lobbies()

func _on_lobby_match_list(lobbies: Array):
	print("On lobby match list")
	
	for lobby_child in lobby_container.get_children():
		lobby_child.queue_free()
		
	for lobby in lobbies:
		var lobby_name: String = Steam.getLobbyData(lobby, "name")
		
		if lobby_name != "":
			var lobby_mode: String = Steam.getLobbyData(lobby, "mode")
			
			var lobby_button: Button = Button.new()
			lobby_button.set_text(lobby_name + "|" + lobby_mode)
			lobby_button.set_size(Vector2(50, 20))
			lobby_button.add_theme_font_size_override("font_size", 7)
			
			#var fv = FontVariation.new()
			#fv.set_base_font(load("res://assets/fonts/PixelOperator8.ttf"))
			#lobby_button.add_theme_font_override("font", fv)
			lobby_button.set_name("lobby_%s" % lobby)
			lobby_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
			lobby_button.connect("pressed", Callable(self, "join_lobby").bind(lobby))
			
			lobby_container.add_child(lobby_button)
