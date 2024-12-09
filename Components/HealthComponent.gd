extends Node



@export_group("Health")
@export var health : int = 100
@export var health_regeneration : int = 1

@export_group("Armour")
@export var armour_amount : int = 0
@export_flags("Flesh:2", "Ossien:4", "Titanium:8", "Ceramic:16") var armour_type: = 0

func take_damage(amount,type):
	pass

func calculate_mitigation():
	match armour_type:
		0: #Nothing
			pass
		2: #Flesh
			pass
		6: #Flesh+Ossien
			pass
		8: #Titanium
			pass
		10: #Flesh+Titanium
			pass
		12: #Ossien+Titanium
			pass
		14: #Flesh+Ossien+Titanum
			pass
		16: #Ceramic
			pass
		18: #Flesh+Ceramic
			pass
		20: #Ossien+Ceramic
			pass
		22: #Flesh+Ossien+Ceramic
			pass
		24: #Titanium+Ceramic
			pass
		26: #Flesh+Titanium+Ceramic
			pass
		28: #Ossien+Titanium+Ceramic
			pass
		30: #Flesh+Ossien+Titanium+Ceramic
			pass
