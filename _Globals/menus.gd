extends Control

var main_menu = preload("res://Menus/main_menu.tscn")
var multiplayer_menu = preload("res://Menus/multiplayer_menu.tscn")
var options_menu
var browse_menu
var lobby_menu = preload("res://Menus/lobby.tscn")
var pause_menu

var interface_scene =  {
	"MainMenu" = preload("res://Menus/main_menu.tscn"),
	"MultiplayerMenu" = preload("res://Menus/multiplayer_menu.tscn"),
	#options_menu ,
	"LobbyMenu" = preload("res://Menus/lobby.tscn"),
	"UserPanel" = preload("res://Menus/user_panel.tscn")
	}



func _ready() -> void:
	#set_anchors_preset(Control.PRESET_FULL_RECT)
	set_size(Vector2(640,360))
	instance_interface("MainMenu")
	instance_interface("UserPanel")

func instance_interface(interface_name):
	var interface = Menus.interface_scene[interface_name].instantiate()
	get_node("/root/Menus").add_child.call_deferred(interface)
	
func remove_interface(interface_name):
	var path = "/root/Menus/"+str(interface_name)
	if get_node(path):
		get_node_or_null(path).queue_free.call_deferred()
