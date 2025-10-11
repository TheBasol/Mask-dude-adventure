extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {
	"lifes": 3,
	"health" : 10
}

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
		file.close()  


func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file.close()  # Cerrar archivo correctamente
