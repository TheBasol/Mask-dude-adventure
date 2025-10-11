extends Area2D

@export var nextLevel : String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.transition_to_scene(nextLevel)
