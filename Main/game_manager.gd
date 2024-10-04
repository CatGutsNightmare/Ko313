extends Node
var lobby_container : Control

func _ready() -> void:
	Steam.lobby_match_list.connect(_on_lobby_match_list)
	if OS.has_feature("dedicated_server"):
		print("Starting dedicated server...")
		%NetworkManager.become_host(true) 

func host_game():
	print("Become host pressed")
	use_steam()
	%NetworkManager.host_game()

func join_game(lobby_id = 0):
	print("Join game pressed")
	use_enet()
	%NetworkManager.join_as_client(lobby_id)

func list_steam_lobbies(container: Control):
	print("Listing Lobbies!")
	use_steam()
	lobby_container = container
	%NetworkManager.list_lobbies()

func join_lobby(lobby_id = 0):
	use_steam()
	print("List Steam Lobbis")
	%NetworkManager.join_as_client(lobby_id)

func use_steam():
	print("Using Steam!")
	%NetworkManager.active_network_type = %NetworkManager.MULTIPLAYER_NETWORK_TYPE.STEAM

func use_enet():
	print("Using Enet")
	%NetworkManager.active_network_type = %NetworkManager.MULTIPLAYER_NETWORK_TYPE.ENET


func _on_lobby_match_list(lobbies: Array):
	print("On lobby match list")
	
	for lobby_child in lobby_container.get_children() :
		lobby_child.queue_free
	
	
	for lobby in lobbies:
		var lobby_name: String = Steam.getLobbyData(lobby, "name")
		
		if lobby_name != "":
			var lobby_mode: String = Steam.getLobbyData(lobby, "mode")
			
			var lobby_button: Button = Button.new()
			lobby_button.set_text(lobby_name + " | " + lobby_mode)
			lobby_button.set_size(Vector2(80, 30))
			lobby_button.add_theme_font_size_override("font_size", 8)
			
			lobby_button.set_name("lobby_%s" % lobby)
			lobby_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
			lobby_button.connect("pressed", Callable(self, "join_lobby").bind(lobby))
			lobby_container.add_child(lobby_button)
