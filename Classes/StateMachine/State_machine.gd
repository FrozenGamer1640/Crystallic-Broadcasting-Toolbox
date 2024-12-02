class_name StateMachine extends Node

# nodo a controlar
@onready var controlled_node:Node = self.owner

# estado por defecto
@export var default_state:State_Base

# estado actual
var current_state:State_Base = null

func _ready():
	call_deferred("_state_default_start")

func _state_default_start() -> void:
	current_state = default_state
	_state_start()

# función que prepara las variables para un nuevo estado
func _state_start() -> void:
	prints("StateMachine: ", controlled_node.name, ", start state: ", current_state.name)
	
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()

# método para cambiar a un nuevo modo
func change_to(new_state:String) -> void:
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(new_state)
	_state_start()

#region métodos que se ejecutan solos

func _process(delta:float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)

#endregion
