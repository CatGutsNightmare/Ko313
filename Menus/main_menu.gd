extends Control

func _on_start_pressed() -> void:
	pass

func _on_multiplayer_pressed() -> void:
	Menus.instance_interface("MultiplayerMenu")
	Menus.remove_interface("MainMenu")

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
