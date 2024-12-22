class_name DiagonalMenuBox extends Control

signal folder_button_toggle(toggled_on:bool, diagonal_button:FolderDiagonalButton, diagonal_menu_box:DiagonalMenuBox)

@export var BoxID:MenuBoxesIdentifiers.BoxesIdentifiers
@export var buttons_container:BoxContainer

func _ready():
	if buttons_container:
		for button:DiagonalButtonBase in buttons_container.get_children():
			if button is FolderDiagonalButton:
				button.folder_button_toggle.connect(_on_FolderDiagonalButton_toggle)

#region signals
func _on_FolderDiagonalButton_toggle(toggled_on:bool, diagonal_button:FolderDiagonalButton) -> void:
	folder_button_toggle.emit(toggled_on, diagonal_button, self)

#endregion
