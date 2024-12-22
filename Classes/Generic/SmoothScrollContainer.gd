@tool
class_name SmoothScrollContainer extends Container

@export var h_slider:ScrollBar: set = set_h_slider
@export var v_slider:ScrollBar: set = set_v_slider
@export var control_ref:Control: set = set_control_ref

@export_custom(PROPERTY_HINT_NONE, "suffix:s") var duration:float = 0.7 ## The duration in seconds of the tweening

@onready var affected_container:Control = control_ref.get_child(0) if control_ref.get_child(0) is Control else null

var h_time:float = 0
var v_time:float = 0

var h_origin_pos:float = 0
var h_target_pos:float = 0
var h_interpolation:float = 0

var v_origin_pos:float = 0
var v_target_pos:float = 0
var v_interpolation:float = 0

#region setters and getters
func set_h_slider(value:ScrollBar) -> void:
	if v_slider and value == v_slider:
		printerr("The horizontal scroll bar can't be the same as the vertical scroll bar") # TODO this line need a translate resource or similar
	else:
		h_slider = value

func set_v_slider(value:ScrollBar) -> void:
	if h_slider and value == h_slider:
		printerr("The vertical scroll bar can't be the same as the horizontal scroll bar") # TODO this line need a translate resource or similar
	else:
		v_slider = value

func set_control_ref(value:Control) -> void:
	control_ref = value
#endregion
#region main
func _ready():
	self.sort_children.connect(_on_sort_children)
	self.pre_sort_children.connect(_on_pre_sort_children)
	
	if affected_container:
		for box:Control in affected_container.get_children():
			if box is DiagonalMenuBox:
				box.visibility_changed.connect(manual_children_sort)
	
	if h_slider:
		h_slider.value_changed.connect(_on_h_slider_value_changed)
		
		h_slider.set_min(0)
		h_slider.set_max(1)
	if v_slider:
		v_slider.value_changed.connect(_on_v_slider_value_changed)
		
		v_slider.set_min(0)
		v_slider.set_max(1)
	

func _process(delta) -> void:
	if h_slider and h_time <= duration:
		h_time += delta
		
		h_interpolation = Tween.interpolate_value(h_origin_pos, (h_target_pos - h_origin_pos), h_time, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
		
		control_ref.set_anchor(SIDE_LEFT, h_interpolation, true)
		control_ref.set_anchor(SIDE_RIGHT, h_interpolation, true)
		
	if v_slider and v_time <= duration:
		v_time += delta
		
		v_interpolation = Tween.interpolate_value(v_origin_pos, (v_target_pos - v_origin_pos), v_time, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
		
		control_ref.set_anchor(SIDE_TOP, v_interpolation, true)
		control_ref.set_anchor(SIDE_BOTTOM, v_interpolation, true)
	
#endregion
#region signals
func manual_children_sort() -> void:
	call_deferred("_on_pre_sort_children")
	call_deferred("_on_sort_children")

func _on_sort_children():
	if affected_container:
		if h_slider:
			h_slider.set_page(self.size.x / affected_container.size.x)
		if v_slider:
			v_slider.set_page(self.size.y / affected_container.size.y)
	

func _on_pre_sort_children():
	if !v_slider:
		control_ref.set_anchor_and_offset(SIDE_TOP, 0, 0)
		control_ref.set_anchor_and_offset(SIDE_BOTTOM, 1, 0)
	if !h_slider:
		control_ref.set_anchor_and_offset(SIDE_LEFT, 0, 0)
		control_ref.set_anchor_and_offset(SIDE_RIGHT, 1, 0)

func _on_h_slider_value_changed(value:float) -> void:
	h_time = 0
	
	h_origin_pos = control_ref.get_anchor(SIDE_LEFT)
	h_target_pos = -value / h_slider.get_page()
	

func _on_v_slider_value_changed(value:float) -> void:
	v_time = 0
	
	v_origin_pos = control_ref.get_anchor(SIDE_TOP)
	v_target_pos = -value / v_slider.get_page()
	
#endregion
