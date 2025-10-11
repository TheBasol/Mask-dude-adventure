extends PlayerState

func state_enter_state(msg := {}):
	player.velocity.x = 0
	player.canDash = true
	player.jumpsNumber = 2  # Solo resetear aquí
	anim_player.play("Idle")
	
func state_physics_process(delta):
		var direction = Input.get_axis("ui_left","ui_right")
		
		player.velocity.x = 0
		
		# Solo aplicar gravedad si no está en el suelo
		if !player.is_on_floor():
			player.velocity.y += player.gravity
		else:
			player.velocity.y = 0  # Solo aquí resetear Y
		
		player.move_and_slide()

		if direction != 0:
			state_machine.transition_to("Moving")
		elif !player.is_on_floor():
			state_machine.transition_to("InAir")
		elif Input.is_action_just_pressed("ui_accept"):
			state_machine.transition_to("InAir",{Jump = true})
		elif Input.is_action_just_pressed("dash") and player.canDash:
			state_machine.transition_to("Dash")
