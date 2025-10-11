extends Area2D

@export var nextLevel : String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_deferred("change_scene_to_file",nextLevel)
