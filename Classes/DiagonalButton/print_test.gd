class_name DiagonalPrintButton extends ActionDiagonalButton

#region main
func _ready() -> void:
	super()


func _process(delta) -> void:
	super(delta)

#endregion
#region signals
func _on_button_down() -> void:
	super()
	print("test")

#endregion
