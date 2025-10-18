extends Node

func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Scenes/world.tscn")
	queue_free()
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().get_root().set_input_as_handled()
	
