extends Entity
var direction = -1
@onready var ray_cast_floor: RayCast2D = $Raycasts/RayCastFloor
@onready var ray_cast_wall: RayCast2D = $Raycasts/RayCastWall
@onready var raycasts: Node2D = $Raycasts
@onready var ray_cast_player_detector: RayCast2D = $RayCastPlayerDetector
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player
var canChangeDirection = true

enum state {ANGRY,WALK, DEAD}
var actualStage = state.WALK

func _ready() -> void:
	dmg = 2
	animation_player.play("walk")
	speed = 60
	
func _process(delta: float) -> void:
	
	if player == null and ray_cast_player_detector.is_colliding():
		var colision = ray_cast_player_detector.get_collider()
		if colision is Player:
			player = colision
			actualStage = state.ANGRY
			speed = 90
	
	if actualStage == state.ANGRY and player != null:
		animation_player.play("run_angry")
		var directionPlayer = global_position.direction_to(player.global_position)
		direction = -1 if directionPlayer.x < 0 else 1 
	
	if actualStage == state.WALK:
		if canChangeDirection and (ray_cast_wall.is_colliding() or !ray_cast_floor.is_colliding()):
			canChangeDirection = false
			$Raycasts/RaycasterTimer.start()
			direction *= -1
			raycasts.scale.x *= -1
			
	$Sprite2D.flip_h = true if direction == 1 else false

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	
	if !is_on_floor():
		velocity.y += 9
	move_and_slide()

func takeDmg(damage):
	life -= damage 
	if life <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		actualStage = state.DEAD		
		animation_player.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await animation_player.animation_finished
		queue_free()

func _on_raycaster_timer_timeout() -> void:
	canChangeDirection = true
