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
		
const SETTINGS_MENU = preload("uid://i3nhww6cp7ir")

func _ready() -> void:
	call_deferred("_initialize_values") 
	
func _unhandled_input(event):
	# Comprueba si se presionó la acción y el juego no está ya pausado
	if event.is_action_pressed("ui_pause") and not get_tree().paused:
		# Pausa el juego
		get_tree().paused = true
		# Crea una instancia del menú de pausa
		var menu = SETTINGS_MENU.instantiate()
		# Añádelo a la escena actual
		get_tree().get_root().add_child(menu)
	else:
		get_tree().paused = false
		

func _initialize_values():
	lifes = Save.game_data.lifes
	health = Save.game_data.health
