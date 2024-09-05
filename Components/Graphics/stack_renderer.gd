class_name StackRenderer
extends Sprite2D

@export var z_depth_offset : int = 0
@export var show_sprites : bool = false : set = set_show_sprites
var total_rotation = 0



func set_show_sprites(_show_sprites):
	show_sprites = _show_sprites
	if show_sprites:
		render_sprites()
	else:
		clear_sprites()
		
func clear_sprites() -> void:
	for sprite in get_children():
		sprite.queue_free()

func roatate_stack(rotation_amount):
	for sprite in get_children():
		sprite.rotation = rotation_amount
		
func _process(delta):
	#total_rotation += delta
	#roatate_stack(total_rotation)
	global_rotation = 0

func _ready() -> void:
	render_sprites()
	self_modulate.a = 0


func render_sprites() -> void:
	clear_sprites()
	for i in range(0, hframes):
		var next_sprite = Sprite2D.new()
		next_sprite.texture = texture
		next_sprite.hframes = hframes
		next_sprite.frame = i
		next_sprite.position.y = -i + z_depth_offset
		next_sprite.z_index = i - z_depth_offset
		add_child(next_sprite)
