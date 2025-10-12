extends Node

var player
var fruits := 0 : 
	set(val):
		fruits = val
		if player != null:
			player.updateUiFruits()
			$AudioStreamPlayer.volume_db = linear_to_db(0.5)
			$AudioStreamPlayer.play()
var lifes: int :
	set(val):
		lifes = val
		Save.game_data.lifes = val
var health: int :
	set(val):
		health = val
		Save.game_data.health = val

func _ready() -> void:
	call_deferred("_initialize_values") 

func _initialize_values():
	lifes = Save.game_data.lifes
	health = Save.game_data.health
