extends Node2D

var is_inside = false

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	pass

func _process(delta):
	if is_inside:
		self.set_global_pos(get_global_mouse_pos())
		#print("Pos: ", get_pos().x, ", ", get_pos().y)

func _on_area_input_event( viewport, event, shape_idx ):
	_click_inside(event)

func _click_inside(event):
	if event.is_action_pressed("left_click"):
		is_inside = true
		
	if event.is_action_released("left_click"):
		is_inside = false