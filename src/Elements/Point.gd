extends RigidBody2D

onready var anim = get_node("anim")

var is_inside = false

func _ready():
	set_process(true)
	set_process_input(true)
	
	#anim.play("show")

func _process(delta):
	if is_inside:
		self.set_global_pos(get_global_mouse_pos())
		Global.player_move = true
	
	outline(self, delta)

func _click_inside(event):
	if event.is_action_pressed("left_click"):
		is_inside = true
		
	if event.is_action_released("left_click"):
		is_inside = false

const MOV_VELOCITY = 500

func outline(point, delta):
	# Si se va hacia la derecha
	if (point.get_pos().x > Global.RES_X - 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x - MOV_VELOCITY * delta, pos.y))
	# Si se va hacia la izquierda
	if (point.get_pos().x < 0 + 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x + MOV_VELOCITY * delta, pos.y))
	# Si se va hacia abajo
	if (point.get_pos().y > Global.RES_Y - 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x, pos.y - MOV_VELOCITY * delta))
	# Si se va hacia arriba
	if (point.get_pos().y < 0 + 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x, pos.y + MOV_VELOCITY * delta))

func _on_ClickArea_input_event( viewport, event, shape_idx ):
	_click_inside(event)
