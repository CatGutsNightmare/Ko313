extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu = load("res://Menus/main_menu.tscn").instantiate()
	get_tree().current_scene.add_child(main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
