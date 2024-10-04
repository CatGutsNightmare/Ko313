extends Node
#################################################
# GODOTSTEAM YOINKY SPLOINKIED STRAIGHT INTO MY PROJECT YO
#################################################

var steam_ap_id = 480 #3227800

var is_on_steam: bool = false
var is_on_steam_deck: bool = false
var is_online: bool = false
var is_owned: bool = false

var steam_id: int = 0
var steam_username: String = "[not set]"

var lobby_id = 0
var lobby_max_members = 4

func _ready() -> void:
	print("Starting the Ko313...")
	_initialize_steam()
	
	Helper.connect_signal(Steam.steamworks_error, _on_steamworks_error)

	if is_on_steam_deck:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN

# Process all Steamworks callbacks
func _process(_delta: float) -> void:
	if is_on_steam:
		Steam.run_callbacks()

func _init() -> void:
	print("Init Steam")
	if Engine.has_singleton("Steam"):
		OS.set_environment("SteamAppId", str(steam_ap_id))
		OS.set_environment("SteamGameId", str(steam_ap_id))
		
#################################################
# INITIALIZING STEAM
#################################################

func _initialize_steam() -> void:
		var init_response: Dictionary = Steam.steamInitEx()
		if init_response['status'] > 0 :
			printerr("[STEAM] Failed to initialize: %s Shutting down..." % str(init_response['verbal']))
			get_tree().quit()

		# Is the user actually using Steam; if false, 
		# the app assumes this is a non-Steam version
		is_on_steam = true
		
		# Checking if the app is on Steam Deck to modify certain behaviors
		is_on_steam_deck = Steam.isSteamRunningOnSteamDeck()
		
		# Acquire information about the user
		is_online = Steam.loggedOn()
		steam_id = Steam.getSteamID()
		steam_username = Steam.getPersonaName()

		# Check if account owns the game
		is_owned = Steam.isSubscribed()
		


# Intended to serve as generic error messaging for failed call results.
# Note: this callback is unique to GodotSteam.
func _on_steamworks_error(failed_signal : String, message : String):
	printerr("[GODOTSTEAM] Steamworks Error! Failed Signal %s: %s" %
			[failed_signal, message]) 
