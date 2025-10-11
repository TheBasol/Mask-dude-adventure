extends Node2D

var dmg := 3
@onready var sprite_2d: Sprite2D = $trueSaw/Sprite2D
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var platformSpeed : float = .2
@onready var true_saw: Node2D = $trueSaw

func _process(delta: float) -> void:
	sprite_2d.rotate(deg_to_rad(400 * delta))
	
	true_saw.global_position = path_follow_2d.global_position
	
	if path_follow_2d.progress_ratio < 1:
		path_follow_2d.progress_ratio += platformSpeed * delta
	else:
		path_follow_2d.progress_ratio = 0
