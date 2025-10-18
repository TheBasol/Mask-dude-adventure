extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {
	"lifes": 3,
	"health" : 10,
	"fullscreen_on": true,
	"screen_res": 1,
	"sfx_vol": -10,
	"music_vol": -10,
	"master_vol" :-10
}

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	if file == null:
		save_data()
	else:
		var data_saved = file.get_var()
		
		for data in game_data.keys():
			if !data_saved.keys().has(data):
				data_saved[data] = game_data[data]
				
			
		game_data = data_saved
		save_data()
		file.close()  


func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file.close()  
