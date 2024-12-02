extends Control

@onready var root = get_tree().root
@onready var texture_button = $TextureButton


const OFFSET_RATIO = 0.265

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ALERT el "700" es el minimum size del %MainPanel  
	texture_button.position.x = -((texture_button.get_screen_position().y - ((root.size.y - 700 ) / 2) ) * OFFSET_RATIO)
