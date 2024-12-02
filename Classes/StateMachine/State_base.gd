class_name State_Base extends Node

@onready var controlled_node:Node = self.owner

var state_machine:StateMachine

#region common methods

func start():
	pass

func end():
	pass

#endregion
