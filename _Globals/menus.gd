extends Control

var main_menu = preload("res://Menus/main_menu.tscn")
var multiplayer_menu = preload("res://Menus/multiplayer_menu.tscn")
var options_menu
var browse_menu
var lobby_menu = preload("res://Menus/lobby.tscn")
var pause_menu

func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT, false)
	load_ui_element(main_menu)
	#var opening_menu = main_menu.instantiate()
	#get_node("/root").add_child.call_deferred(opening_menu) #UI must be a direct child of the root node otherwise you can go FUCKYOURSELF

func load_ui_element(element_to_load):
	var new_ui_element = element_to_load.instantiate()
	get_node("/root").add_child.call_deferred(new_ui_element)
