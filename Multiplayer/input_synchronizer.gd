extends MultiplayerSynchronizer

@onready var player = $".."
var rotation_direction
var movement_direction
var EOT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	EOT = 3
	movement_direction = Input.get_axis("down","up")
	rotation_direction = Input.get_axis("left", "right") 

func _physics_process(delta: float) -> void:
	movement_direction = Input.get_axis("down","up")
	rotation_direction = Input.get_axis("left", "right") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@rpc("call_local")
func start():
	if multiplayer.server():
		pass

@rpc("call_local")
func select():
	if multiplayer.server():
		pass

@rpc("call_local")
func fire():
	if multiplayer.server():
		pass

@rpc("call_local")
func alt_fire():
	if multiplayer.server():
		pass
