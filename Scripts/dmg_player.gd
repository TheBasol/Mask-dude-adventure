extends Area2D

@export var dmg := 1

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("AreaPlayer"):
		area.owner.takeDamage(dmg)
