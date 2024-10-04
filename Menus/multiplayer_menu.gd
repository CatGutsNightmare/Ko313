extends Control

@onready var game_manager : Node = get_node("/root/Main/GameManager")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.



func _on_host_pressed() -> void:
	#var next_menu = Menus.lobby_menu.instantiate()
	#get_parent().add_child(next_menu)
	#queue_free()
	game_manager.host_game()
	queue_free()

func _on_browse_pressed() -> void:
	game_manager.join_game()
	queue_free()


func _on_back_pressed() -> void:
	var next_menu = Menus.main_menu.instantiate()
	get_parent().add_child(next_menu)
	queue_free()


func _on_host_p_2p_game_pressed() -> void:
	pass # Replace with function body.


func _on_list_lobbies_pressed() -> void:
	print("List Steam Lobbies!")
	game_manager.list_steam_lobbies($SteamHud/Panel/Lobbies/VBoxContainer)
	
