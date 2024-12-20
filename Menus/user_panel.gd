extends MarginContainer



@onready var portrait: TextureRect = $Panel/MarginContainer/HBoxContainer/Portrait
@onready var name_container: Label = $Panel/MarginContainer/HBoxContainer/Name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Helper.connect_signal(Steam.avatar_loaded, _on_avatar_loaded)
	Steam.getPlayerAvatar(Steam.AVATAR_SMALL, Global.steam_id)
	name_container.set_text(str(Global.steam_username))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_avatar_loaded(id: int, avatar_size: int, buffer: PackedByteArray) -> void:
	print("Avatar for user: "+str(id)+", size: "+str(avatar_size))

	# Create the image and texture for loading
	var avatar_image: Image = Image.create_from_data(avatar_size, avatar_size, 
			false, Image.FORMAT_RGBA8, buffer)
		
	var avatar_texture : ImageTexture = ImageTexture.create_from_image(avatar_image)	
			
	# Display it
	portrait.texture = avatar_texture
