class_name Player
extends CharacterBody2D

var speed := 120
var direccion := 0.0
var jump = 250
const gravity = 9
var damage = 1
var jumpsNumber = 2
var canDash = true
var life := 10 :
	set(val):
		life = val
		$PlayerGUI/ProgressBar.value = life

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var fruits_2: Label = $PlayerGUI/HBoxContainer/Fruits2
@onready var raycast_dmg: Node2D = $RaycastDmg
@onready var area_to_take_damage: Area2D = $areaToTakeDamage
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	$PlayerGUI/ProgressBar.value = life
	fruits_2.text = str(Global.fruits)
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
		life -= dmg
		state_machine.transition_to("TakeDamage")
		if life <= 0:
			dead()
	
func dead():
	get_tree().call_deferred("reload_current_scene")

func updateUiFruits():

	fruits_2.text = str(Global.fruits)
