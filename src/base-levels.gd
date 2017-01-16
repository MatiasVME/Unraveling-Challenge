extends Node2D

onready var res_point = load("res://scenes/point.tscn")
onready var lab_inter = get_node("num_inter")

# Puntos en pantalla
var points
var lines = [] 
var num_inter = 0
var current_inter = 0 # Utilizar este para las intersecciones actuales

func _ready():
	set_process(true)
	randomize()
	
	create_level(1)

func _process(delta):
	update_points()
	
	# Si se sale de los límites mueve los puntos a un lugar cercano
	for i in points:
		outline(i, delta)
	
	update()

func _draw():
	if global.get_current_level() == 1:
		_level(1)

func _level(level):
	if level == 1:
		update_points()
		restore_lines()
		draw_conect_with_everyone()
		show_collision()
		show_label_intersection()
		
		print(current_inter)
		
		while current_inter < global.levels["level_1"]["min_inter"]:
			print("hola")
			delete_points()
			create_level(1)
			

const MOV_VELOCITY = 500

func outline(point, delta):
	# Si se va hacia la derecha
	if (point.get_pos().x > global.RES_X - 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x - MOV_VELOCITY * delta, pos.y))
	# Si se va hacia la izquierda
	if (point.get_pos().x < 0 + 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x + MOV_VELOCITY * delta, pos.y))
	# Si se va hacia abajo
	if (point.get_pos().y > global.RES_Y - 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x, pos.y - MOV_VELOCITY * delta))
	# Si se va hacia arriba
	if (point.get_pos().y < 0 + 50):
		var pos = point.get_pos()
		point.set_pos(Vector2(pos.x, pos.y + MOV_VELOCITY * delta))

func update_points():
	points = get_tree().get_nodes_in_group("Points")
	
func restore_lines():
	lines = []
	
func draw_conect_with_everyone():
	var i = 0
	var j = 0
		
	# Dibuja líneas y las almacena en un array
		
	while i < points.size():
		while j <= points.size():
			if j < points.size() - 1:
				draw_line(points[i].get_pos(), points[j + 1].get_pos(), Color(0.5, 0, 0.5), 5)
				var line = [points[i].get_pos(), points[j + 1].get_pos()]
				lines.append(line)
			j += 1
		i += 1
		j = i
		
func show_collision():
	var i = 0
	var j = 0
		
	# Muestra las colisiones

	while i < lines.size():
		while j <= lines.size():
			if j < lines.size() - 1:
				var inter = calc.intersection(lines[i][0], lines[i][1], lines[j + 1][0], lines[j + 1][1])
				if inter != null:
					draw_circle(inter, 10, Color(0.5, 0.5, 0, 0.5))
					num_inter += 1
			j += 1
		i += 1
		j = i
		
func show_label_intersection():
	lab_inter.set_text(str(num_inter))
	current_inter = num_inter
	num_inter = 0
	
func delete_points():
	for i in points:
		i.queue_free()
		
func create_level(num_level):
	var num_points = global.levels["level_"+str(num_level)]["points"]
	var min_inter = global.levels["level_"+str(num_level)]["min_inter"]
	var current_points = 0
	
	# Instancia y posiciona los puntos aleatoriamente
	while current_points < num_points:
		var instance_point = res_point.instance()
		add_child(instance_point)
		instance_point.add_to_group("Points")
		var pos_x = rand_range(0 + 100, global.RES_X - 100)
		var pos_y = rand_range(0 + 100, global.RES_Y - 100)
		instance_point.set_pos(Vector2(pos_x, pos_y))
		
		current_points += 1