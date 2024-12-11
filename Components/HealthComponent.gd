extends Node

signal health_depleted

@export_group("Health")
@export var max_health : int = 100
@export var current_health : int = 100
@export var health_regeneration : int = 1

var timer = 1

@export_group("Armour")
@export var armour_value : int = 0

func _physics_process(delta: float) -> void:
	timer - delta
	if timer <= delta:
		tick()
		timer = 1

func take_damage(amount):
	var damage_to_take = amount - armour_value
	if damage_to_take > current_health:
		damage_to_take = current_health
	current_health = current_health - damage_to_take
	if current_health <= 0:
		health_depleted.emit()

func tick():
	if current_health > 0 and current_health < max_health:
		var health_to_regain = health_regeneration + current_health
		if health_to_regain > max_health :
			health_to_regain = max_health - current_health
		current_health += health_to_regain
