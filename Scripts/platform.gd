@tool
extends Path2D

@export var platformSpeed : float = .2

func _process(delta: float) -> void:
	$Platform.global_position = $PathFollow2D.global_position
	
	if $PathFollow2D.progress_ratio < 1:
		$PathFollow2D.progress_ratio += platformSpeed * delta
	else:
		$PathFollow2D.progress_ratio = 0
		
