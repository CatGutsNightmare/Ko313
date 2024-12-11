extends CharacterBody2D

class_name Ship

var eot_timer = true

enum speeds {FULLASTERN,HALFASTERN,SLOWASTERN,STOP,SLOWAHEAD,HALFAHEAD,FULLAHEAD}


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

enum EOT_Speeds {FULLASTERN,HALFASTERN,SLOWASTERN,STOP,SLOWAHEAD,HALFAHEAD,FULLAHEAD}

@export_group("Misc")
@export var rotation_speed = 2
@export var acceleration = 5
@export var drag = 0.3
@export_category("")

var EOT = EOT_Speeds.STOP
var desired_speed = 0
var current_speed = 0
var rotation_direction = 0

@export_category("Hull Stats")
@export_group("Health")
@export var Maxiumum_Health : int = 100
@export var Health_Regeneration : int = 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

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

func set_desired_speed():
	match EOT:
		EOT_Speeds.FULLASTERN:
			desired_speed = full_astern
		EOT_Speeds.HALFASTERN:
			desired_speed = half_astern
		EOT_Speeds.SLOWASTERN:
			desired_speed = slow_astern
		EOT_Speeds.STOP:
			desired_speed = stop
		EOT_Speeds.SLOWAHEAD:
			desired_speed = slow_ahead
		EOT_Speeds.HALFAHEAD: 
			desired_speed = half_ahead
		EOT_Speeds.FULLAHEAD: 
			desired_speed = full_ahead
