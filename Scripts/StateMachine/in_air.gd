extends PlayerState

var hasJump = false

func state_enter_state(msg := {}):
	if msg.has("Jump"):
		hasJump = true
		player.jumpsNumber -= 1
		$"../../AudioStreamJump".play()
		anim_player.play("jump")
		player.velocity.y = -player.jump
		
		if player.jumpsNumber == 0:
			anim_player.play("doubleJump")
	else:
		$CoyoteTimer.start()
		anim_player.play("fall")
		
		
func state_physics_process(delta):
	var direction = Input.get_axis("ui_left","ui_right")
	player.sprite_2d.flip_h = direction < 0 if direction != 0 else player.sprite_2d.flip_h
	player.velocity.x = direction * player.speed
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if player.is_on_floor():
		$CoyoteTimer.stop()
		state_machine.transition_to("Idle")
		
	if !$BufferJumpTimer.is_stopped() and player.is_on_floor():
		$BufferJumpTimer.stop()
		state_machine.transition_to("InAir",{Jump = true})
	elif hasJump and Input.is_action_just_pressed("ui_accept") and player.jumpsNumber > 0:
		state_machine.transition_to("InAir",{Jump = true})
		hasJump = false
	#coyotejump
	elif !$CoyoteTimer.is_stopped() and Input.is_action_just_pressed("ui_accept") and player.jumpsNumber > 0:
		print("coyote")
		state_machine.transition_to("InAir",{Jump = true})
	elif player.is_on_wall():
		state_machine.transition_to("WallSlide")
	elif Input.is_action_just_pressed("ui_accept"):
		$BufferJumpTimer.start()
	elif Input.is_action_just_pressed("dash") and player.canDash:
		state_machine.transition_to("Dash")
		


		
