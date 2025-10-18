extends PlayerState

func state_enter_state(msg := {}):
	$"../../AudioStreamHurt".play()	
	anim_player.play("hurt")
	player.area_to_take_damage.set_deferred("disabled",true)
	player.velocity.y = -player.jump
	player.invincibility_timer.start()


func state_physics_process(delta):
	if not player.invincibility_timer.is_stopped():
		player.sprite_2d.modulate.a = sin(Time.get_ticks_msec() * 0.02) * 0.5 + 0.5
	var direction = Input.get_axis("ui_left","ui_right")
	player.sprite_2d.flip_h = direction < 0 if direction != 0 else player.sprite_2d.flip_h
	player.velocity.x = direction * player.speed
	player.velocity.y += player.gravity
	player.move_and_slide()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		state_machine.transition_to("Idle")
