extends CharacterBody2D

class_name Projectile

var current_speed = 0
var desired_speed = 0
var acceleration = 5
var drag = 0.3
var rotation_direction = 0


var movement_stats = {"MaximumSpeed":250,"Acceleration":5,"Drag":0.3}

var damage_stats = {"ImpactDamage":10,"DamageType":1,"Penetration":0}

var health_stats = {"Health":2,"Armour":0,"HealthRegeneration":0,"LifeTime":5}

var sprite 

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
