extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	var player = load("res://Player/player.tscn").instantiate()
	get_parent().add_child(player)
	queue_free()


func _on_host_pressed() -> void:
	#var world = load("res://Multiplayer/multiplayer_world.tscn").instantiate()
	#get_parent().add_child(world)
	MultiplayerManager.become_host()
	queue_free()

func _on_join_pressed() -> void:
	MultiplayerManager.join_game()
	queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()
