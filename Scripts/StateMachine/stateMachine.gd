class_name StateMachine
extends Node

signal changeState(state_name)

@export var initial_state := NodePath()

@onready var state : State = get_node(initial_state)

func _ready():
	await (owner.ready)
	for child in get_children():
		child.state_machine = self
	state.state_enter_state()
	
func _unhandled_input(event: InputEvent) -> void:
	state.state_input(event)
	
func _process(delta: float) -> void:
	state.state_process(delta)
	
func _physics_process(delta: float) -> void:
	state.state_physics_process(delta)
	
func transition_to(target_state: String, msg: Dictionary = {}):
	if not has_node(target_state):
		return
	state.state_exit()
	state = get_node(target_state)
	state.state_enter_state(msg)	
	emit_signal("changeState",state.name)
		
	
