extends CanvasLayer

@onready var fullscreen_check_box: CheckBox = $Panel/VBoxContainer/FullScreenContainer/FullscreenCheckBox
@onready var windows_size_check_box: OptionButton = $Panel/VBoxContainer/WindowsSizeContainer/WindowsSizeCheckBox
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/SFXContainer/sfxSlider
@onready var music_slider: HSlider = $Panel/VBoxContainer/musicContainer2/musicSlider
@onready var master_slider: HSlider = $Panel/VBoxContainer/masterContainer3/masterSlider

func _ready():
	# Inicializar los controles con los datos guardados
	load_settings()

func load_settings():
	# Cargar configuración de fullscreen
	fullscreen_check_box.button_pressed = Save.game_data.fullscreen_on
	
	# Cargar resolución
	windows_size_check_box.selected = Save.game_data.screen_res
	
	# Cargar volúmenes
	sfx_slider.value = Save.game_data.sfx_vol
	music_slider.value = Save.game_data.music_vol
	master_slider.value = Save.game_data.master_vol
	
	# Aplicar la configuración actual
	changeResolution()

func _on_button_pressed() -> void:
	hide()


func _on_fullscreen_check_box_pressed() -> void:
	changeResolution()


func _on_windows_size_check_box_item_selected(index: int) -> void:
	var size : Vector2
	
	match index:
		0: 
			size = Vector2(640,360)
		1:
			size = Vector2(1280,720)
		2:
			size = Vector2(1920,1080)
			
	DisplayServer.window_set_size(size)
	Save.game_data.screen_res = index
	Save.save_data()


func _on_sfx_slider_changed() -> void:
	pass # Replace with function body.


func _on_music_slider_changed() -> void:
	pass # Replace with function body.


func _on_master_slider_changed() -> void:
	pass # Replace with function body.

func changeResolution()-> void:
	if fullscreen_check_box.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		windows_size_check_box.disabled = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		windows_size_check_box.disabled = false
		
	Save.game_data.fullscreen_on = fullscreen_check_box.button_pressed
	Save.save_data()
	
func updateVol(index,vol):
	AudioServer.set_bus_volume_db(index,vol)
	
	match index:
		0:
			Save.game_data.master_vol = vol
		2:
			Save.game_data.sfx_vol = vol
		1:
			Save.game_data.music_vol =vol
			
	Save.save_data()

func _on_sfx_slider_value_changed(value: float) -> void:
	updateVol(2,value)


func _on_music_slider_value_changed(value: float) -> void:
	updateVol(1,value)


func _on_master_slider_value_changed(value: float) -> void:
	updateVol(0,value)
