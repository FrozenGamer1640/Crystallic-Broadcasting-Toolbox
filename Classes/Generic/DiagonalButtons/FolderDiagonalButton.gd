class_name FolderDiagonalButton extends DiagonalButtonBase

signal folder_button_toggle(toggled_on:bool, diagonal_button:FolderDiagonalButton)

@export var TargetBoxID:MenuBoxesIdentifiers.BoxesIdentifiers

#region main
func _ready() -> void:
	super()
	texture_button.toggled.connect(_on_button_toggled)


func _process(delta) -> void:
	super(delta)

#endregion
#region signals
func _on_button_down() -> void:
	pass

func _on_button_toggled(toggled_on:bool) -> void:
	folder_button_toggle.emit(toggled_on, self)

#endregion
