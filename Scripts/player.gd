class_name Player
extends CharacterBody2D

var speed := 120
var direccion := 0.0
var jump = 250
const gravity = 9
var damage = 1
var jumpsNumber = 2
var canDash = true
var health := 10 :
	set(val):
		health = val
		$PlayerGUI/ProgressBar.value = health

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var fruits_2: Label = $PlayerGUI/HBoxContainer/Fruits2
@onready var raycast_dmg: Node2D = $RaycastDmg
@onready var area_to_take_damage: Area2D = $areaToTakeDamage
@onready var state_machine: StateMachine = $StateMachine
@onready var gui_animation_player: AnimationPlayer = $PlayerGUI/AnimationPlayer
@onready var lifes_ui: Label = $PlayerGUI/HBoxContainer2/Lifes
@onready var wall_ray_cast_top: RayCast2D = $WallSlide/WallRayCastTop
@onready var wall_ray_cast_bottom: RayCast2D = $WallSlide/WallRayCastBottom
@onready var invincibility_timer: Timer = $InvincibilityTimer



func _ready() -> void:
	health = Global.health
	$PlayerGUI/ProgressBar.value = health
	fruits_2.text = str(Global.fruits)
	lifes_ui.text = "x"+str(Global.lifes)
	
	gui_animation_player.play("Transition_Anim")
	Global.player = self

func _process(delta: float) -> void:
	
	for ray in raycast_dmg.get_children():
		if ray.is_colliding():
			var colliding = ray.get_collider()
			if colliding != null:
				if colliding.is_in_group("Enemys") and colliding.has_method("takeDmg"):
					colliding.takeDmg(damage)
					#saltar aprovechando a un enemigo
					state_machine.transition_to("InAir", {Jump = true})
					jumpsNumber +=1
					
func takeDamage(dmg):
		health -= dmg
		state_machine.transition_to("TakeDamage")
		if health <= 0:
			dead()
	
func dead():
	Global.lifes -= 1
	if  Global.lifes <= 0:
		Global.lifes = 3
		get_tree().call_deferred("change_scene_to_file","res://main_menu.tscn")
	else:
		get_tree().call_deferred("reload_current_scene")
		
	Global.fruits = 0
	Global.health = 10
		
	Save.save_data()
		
func is_on_valid_wall() -> bool:
	return wall_ray_cast_top.is_colliding() and wall_ray_cast_bottom.is_colliding()

func transition_to_scene(scene:String):
	get_tree().call_deferred("change_scene_to_file",scene)


func updateUiFruits():
	fruits_2.text = str(Global.fruits)


func _on_invincibility_timer_timeout() -> void:
	area_to_take_damage.set_deferred("disabled", false)
	sprite_2d.modulate.a = 1.0
