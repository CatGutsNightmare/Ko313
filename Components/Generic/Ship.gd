extends CharacterBody2D

class_name Ship

@export var renderer : StackRenderer 

@export_category("Speed Stats")
@export_group("Engine Order Telegraph")
@export var full_astern : int = -30
@export var half_astern : int = -20
@export var slow_astern : int = -10
@export var stop       : int = 0
@export var slow_ahead  : int = 20
@export var half_ahead  : int = 40
@export var full_ahead  : int = 60

enum EOT_speeds {FULLASTERN,HALFASTERN,SLOWASTERN,STOP,SLOWAHEAD,HALFAHEAD,FULLAHEAD}

@export_group("Misc")
@export var rotation_speed = 2
@export var acceleration = 5
@export var drag = 0.3
@export_category("")

var EOT_ready = true
var EOT_timer : float = .5
var EOT : int = EOT_speeds.STOP
var desired_speed = 0
var current_speed = 0
var rotation_direction = 0

@export_category("Hull Stats")
@export_group("Health")
@export var maximum_health : int = 100
@export var health_regeneration : int = 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	capture_inputs()
	EOT_timer_driver(1,delta)


## This function handles acceleration, velocity & drag.
## This function holds up proper movement and is not to be changed even on pain of death.
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

## The following function is a  bypass for a basic timer.
func EOT_timer_driver(the_rest_amount:float,time_increment:float):
	if !EOT_ready:
		EOT_timer = EOT_timer - time_increment
		if EOT_timer <= 0:
			EOT_ready = true
			EOT_timer = the_rest_amount
			print(str(EOT))


func set_desired_speed():
	match EOT:
		EOT_speeds.FULLASTERN:
			desired_speed = full_astern
		EOT_speeds.HALFASTERN:
			desired_speed = half_astern
		EOT_speeds.SLOWASTERN:
			desired_speed = slow_astern
		EOT_speeds.STOP:
			desired_speed = stop
		EOT_speeds.SLOWAHEAD:
			desired_speed = slow_ahead
		EOT_speeds.HALFAHEAD: 
			desired_speed = half_ahead
		EOT_speeds.FULLAHEAD: 
			desired_speed = full_ahead

func capture_inputs():
	if Input.is_action_pressed("up") && EOT != EOT_speeds.FULLAHEAD  && EOT_ready:
		EOT_ready = false
		EOT += 1
	#elif Input.is_action_just_pressed("up") && EOT <=6:
		#EOT += 1
	#elif Input.is_action_pressed("down") && EOT >= 0 && EOT_ready:
		#EOT_ready = false
#
		#EOT+= -1
	#elif Input.is_action_just_pressed("down") && EOT >= 0:
		#EOT+= -1
	#rotation_direction = Input.get_axis("left", "right") 
