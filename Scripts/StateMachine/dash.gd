extends PlayerState

var dashSpeed = 400

func state_enter_state(msg := {}):
	
	var directionY = Input.get_axis("ui_up","ui_down") * dashSpeed
	var directionX = Input.get_axis("ui_left","ui_right") * dashSpeed
	
	if directionY > 0:
		player.velocity.y = directionY
	if directionX > 0:
		player.velocity.x =  directionX
	else:
		var directionDash =  -1 if $"../../Sprite2D".flip_h else 1
		
		player.velocity.x =  directionDash * dashSpeed
	$DashTimer.start()
	player.canDash = false
	
func state_physics_process(delta):
	player.move_and_slide()


func _on_dash_timer_timeout() -> void:
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif player.is_on_wall():
		state_machine.transition_to("WallSlide")
	elif !player.is_on_floor():
		state_machine.transition_to("InAir")
