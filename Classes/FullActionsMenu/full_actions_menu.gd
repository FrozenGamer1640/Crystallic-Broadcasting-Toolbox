class_name FullActionsMenu extends CanvasLayer

@export var menu_boxes_container:BoxContainer

var boxes:Dictionary

func _ready() -> void:
	if !menu_boxes_container:
		printerr("menu_boxes_container not defined in FullActionsMenu")
	else:
		for box:DiagonalMenuBox in menu_boxes_container.get_children():
			if boxes.has(box.BoxID):
				printerr("a duplicated menu box was found in the FullActionsMenu")
			else:
				boxes[box.BoxID] = box
				box.folder_button_toggle.connect(on_folder_button_toggle)
		
		for box_key:MenuBoxesIdentifiers.BoxesIdentifiers in boxes.keys():
			if box_key > MenuBoxesIdentifiers.BoxesIdentifiers.QUICK_ACTIONS:
				boxes[box_key].set_visible(false)

#region signals
func on_folder_button_toggle(toggled_on:bool, diagonal_button:FolderDiagonalButton, diagonal_menu_box:DiagonalMenuBox) -> void:
	if !boxes.has(diagonal_button.TargetBoxID):
		printerr("MenuBoxesIdentifiers.BoxesIdentifiers." + str(diagonal_button.TargetBoxID) + " does not exist in FullActionsMenu boxes dict")
	else:
		boxes[diagonal_button.TargetBoxID].set_visible(toggled_on)

#endregion
