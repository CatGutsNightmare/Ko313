extends CharacterBody2D

var current_speed = 0
var desired_speed = 0
var acceleration = 5
var drag = 0.3
var rotation_direction = 0

@onready var renderer : StackRenderer = $StackRenderer
@onready var EOTTimer := $EOTTimer

@onready var bullet_instance := preload("res://Projectiles/bullet.tscn")


func _ready() -> void:
	current_speed = 250
	desired_speed =  250

func _physics_process(delta: float) -> void:
	velocity = calculate_velocity(delta, transform.x,acceleration,drag)
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()

func calculate_velocity(delta, transform_factor, acceleration, drag):
	if current_speed < desired_speed:
		current_speed += acceleration * drag
	elif current_speed > desired_speed:
		current_speed -= acceleration * drag
	var velocity = transform_factor * current_speed 
	return velocity 

func calculate_rotation(delta, rotation, rotation_speed):
	rotation += rotation_direction * rotation_speed * delta
	return rotation
