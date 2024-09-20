extends Control

var game_manager : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.



func _on_host_pressed() -> void:
	#var next_menu = Menus.lobby_menu.instantiate()
	#get_parent().add_child(next_menu)
	#queue_free()
	game_manager = get_node("/root/Main/GameManager")
	game_manager.host_game()
	queue_free()

func _on_browse_pressed() -> void:
	game_manager  = get_node("/root/Main/GameManager")
	game_manager.join_game()
	queue_free()


func _on_back_pressed() -> void:
	var next_menu = Menus.main_menu.instantiate()
	get_parent().add_child(next_menu)
	queue_free()
