extends PlayerState

var canChangeState = false
var direction : float

func state_enter_state(msg := {}):
	canChangeState = false
	direction = Input.get_axis("ui_left","ui_right")
	player.velocity = Vector2.ZERO

func state_physics_process(delta):
	#player.sprite_2d.flip_h = direction < 0 if direction != 0 else player.sprite_2d.flip_h
	player.velocity.y = lerpf(player.velocity.y, -player.jump, 0.9)
	player.velocity.x = lerpf(player.velocity.x, -direction * player.jump, 0.9)
	
	if player.velocity.y == -player.jump:
		canChangeState = true
	player.move_and_slide()
	
	if canChangeState and !player.is_on_floor():
		state_machine.transition_to("InAir")
