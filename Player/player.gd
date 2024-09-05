extends CharacterBody2D

var EOT = 3 # Engine Order Telegraph
var eot_timer = true

enum speeds {FULLASTERN = -30, HALFASTERN = -20,SLOWASTERN = -10,STOP = 0, SLOWAHEAD = 20, HALFAHEAD = 40, FULLAHEAD= 60}

var current_speed = 0
var desired_speed = 0
var rotation_speed = 2
var rotation_direction = 0
var acceleration = 5
var drag = 0.3

@onready var renderer : StackRenderer = $StackRenderer
@onready var EOTTimer := $EOTTimer

@onready var bullet_instance := preload("res://Projectiles/bullet.tscn")

func _physics_process(delta):
	capture_inputs()
	set_speed()
	calculate_velocity(transform.x, acceleration, drag)
	calculate_rotation(delta)
	
	if Input.is_action_just_pressed("button1"):
		var new_shot = bullet_instance.instantiate()
		new_shot.rotation = rotation
		new_shot.global_position = global_position
		get_node("/root").add_child(new_shot)
		

	move_and_slide()
	#look_at(get_global_mouse_position())
	renderer.roatate_stack(rotation)

func capture_inputs():
	if Input.is_action_pressed("up") && EOT <=6 && eot_timer == true:
		eot_timer = false
		EOTTimer.start()
		EOT += 1
	elif Input.is_action_just_pressed("up") && EOT <=6:
		EOT += 1
	elif Input.is_action_pressed("down") && EOT >= 0 && eot_timer == true:
		eot_timer = false
		EOTTimer.start()
		EOT+= -1
	elif Input.is_action_just_pressed("down") && EOT >= 0:
		EOT+= -1
	rotation_direction = Input.get_axis("left", "right") 

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
