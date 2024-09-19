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
	calculate_velocity(transform.x)
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()

func calculate_velocity( transform_factor):
	if current_speed < desired_speed:
		current_speed += acceleration * drag
	elif current_speed > desired_speed:
		current_speed -= acceleration * drag
	velocity = transform_factor * current_speed 
	

func calculate_rotation(delta, rotation_speed):
	rotation += rotation_direction * rotation_speed * delta
