extends Node

var is_on_steam_deck: bool = false
var is_online: bool = false
var is_owned: bool =false
var steam_app_id: int = 3227800
var steam_id: int = 0
var steam_username: String = ""


func _init() -> void:
	# Set your game's Steam app ID here
	OS.set_environment("SteamAppId", str(3227800))
	OS.set_environment("SteamGameId", str(3227800))

func _ready() -> void:
	initialize_steam()


func _process(delta: float) -> void:
	Steam.run_callbacks()

func initialize_steam() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Did steam intitalize?: %s " % initialize_response)
	
	if initialize_response['status'] > 0:
		print("Failed to initialize Steam, shutting down: %s" % initialize_response )
		get_tree().quit()
	#Gathering data
	is_on_steam_deck = Steam.isSteamRunningOnSteamDeck()
	is_online = Steam.loggedOn()
	is_owned = Steam.isSubscribed()
	is_owned = Steam.getSteamID()
	steam_username = Steam.getPersonaName()
