extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	var next_menu = Menus.lobby_menu.instantiate()
	get_parent().add_child(next_menu)
	queue_free()

func _on_browse_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	var next_menu = Menus.main_menu.instantiate()
	get_parent().add_child(next_menu)
	queue_free()
