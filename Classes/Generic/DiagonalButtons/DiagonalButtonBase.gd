class_name DiagonalButtonBase extends Control

@export var texture_button:TextureButton

#region main
func _ready() -> void:
	if !texture_button:
		print_debug("The texture_button var is not defined! this DiagonalButton will be fully decorative!")
	else:
		texture_button.button_down.connect(_on_button_down)

func _process(delta):
	pass

#endregion
#region signals
func _on_button_down() -> void:
	pass

#endregion
