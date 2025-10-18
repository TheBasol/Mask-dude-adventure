extends Area2D

@export var dmg := 1

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("AreaPlayer"):
		var player = area.owner
		if player.invincibility_timer.is_stopped():
			player.state_machine.transition_to("Hurt")
			player.takeDamage(dmg)
