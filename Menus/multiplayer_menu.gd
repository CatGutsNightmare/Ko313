extends Control

var game_manager : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.



func _on_host_pressed() -> void:
	#var next_menu = Menus.lobby_menu.instantiate()
	#get_parent().add_child(next_menu)
	#queue_free()
	#game_manager = get_node("/root/Main/GameManager")
	get_node("/root/Main/GameManager").host_game()
	queue_free()

func _on_browse_pressed() -> void:
	get_node("/root/Main/GameManager").join_lobby()
	queue_free()


func _on_back_pressed() -> void:
	Menus.instance_interface("MainMenu")
	Menus.remove_interface("MultiplayerMenu")

func _on_host_steam_pressed() -> void:
	get_node("/root/Main/GameManager").host_game(1)
	Menus.remove_interface("UserPanel")
	Menus.remove_interface("MultiplayerMenu")

func _on_list_lobbies_pressed() -> void:
	get_node("/root/Main/GameManager").list_steam_lobbies()
	get_node("/root/Main/GameManager").lobby_container = $SteamHUD/Panel/VBoxContainer2/ScrollContainer/LobbyContainer
	pass
