extends MultiplayerSynchronizer

var input_direction
var EOT = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	input_direction = Input.get_axis("left", "right") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("up") && EOT <=6 && get_parent().eot_timer == true:
		get_parent().eot_timer = false
		get_parent().EOTTimer.start()
		EOT += 1
	elif Input.is_action_just_pressed("up") && EOT <6:
		EOT += 1
	elif Input.is_action_pressed("down") && EOT > 0 && get_parent().eot_timer == true:
		get_parent().eot_timer = false
		get_parent().EOTTimer.start()
		EOT+= -1
	elif Input.is_action_just_pressed("down") && EOT > 0:
		EOT+= -1
		
	input_direction = Input.get_axis("left", "right") 
