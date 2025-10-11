extends Node


func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Scenes/world.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_3_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
