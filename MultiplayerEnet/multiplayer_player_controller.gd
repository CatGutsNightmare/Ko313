extends CharacterBody2D

var EOT = 3 # Engine Order Telegraph
var eot_timer = true

enum speeds {FULLASTERN = -30, HALFASTERN = -20,SLOWASTERN = -10,STOP = 0, SLOWAHEAD = 20, HALFAHEAD = 40, FULLAHEAD= 60}
var current_speed = 0
var desired_speed = 0
var rotation_speed = 2
var acceleration = 5
var drag = 0.3

@export var player_id := 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(id)

var rotation_direction = 0
var movement_direction = 0

@onready var renderer : StackRenderer = $StackRenderer
@onready var EOTTimer := $EOTTimer
func _ready() -> void:
	if multiplayer.get_unique_id() == player_id:
		$Camera2D.make_current()
	else:
		$Camera2D.enabled = false
	pass
func _physics_process(delta):
	if multiplayer.is_server():
		_apply_movement_from_input(delta)
	
	renderer.roatate_stack(rotation)

func _apply_movement_from_input(delta):
	rotation_direction = %InputSynchronizer.rotation_direction
	movement_direction = %InputSynchronizer.movement_direction
	#EOT = %InputSynchronizer.EOT
	
	set_EOT()
	set_speed()
	calculate_velocity(transform.x,acceleration,drag)
	calculate_rotation(delta)
	
	move_and_slide()
	
func apply_graphics(delta):
	pass
func set_EOT():
	if movement_direction > 0 and eot_timer == true and EOT <= 5:
		EOT += 1
		eot_timer = false
		EOTTimer.start()
	if movement_direction < 0 and eot_timer == true and EOT >= 1:
		EOT += -1
		eot_timer = false
		EOTTimer.start()
func set_speed():
	match EOT:
		0:
			desired_speed = speeds.FULLASTERN
		1:
			desired_speed = speeds.HALFASTERN
		2:
			desired_speed = speeds.SLOWASTERN
		3:
			desired_speed = speeds.STOP
		4:
			desired_speed = speeds.SLOWAHEAD
		5: 
			desired_speed = speeds.HALFAHEAD
		6: 
			desired_speed = speeds.FULLAHEAD

func calculate_velocity(transform_factor, acceleration, drag):
	
	if current_speed < desired_speed:
		current_speed += acceleration * drag
	elif current_speed > desired_speed:
		current_speed -= acceleration * drag
	if current_speed == desired_speed:
		pass
	velocity = transform_factor * current_speed 

func calculate_rotation(delta):
	rotation += rotation_direction * rotation_speed * delta


func _on_eot_timer_timeout() -> void:
	eot_timer = true
