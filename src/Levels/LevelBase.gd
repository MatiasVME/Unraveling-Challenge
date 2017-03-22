extends Node2D

var lines = []
var cont_inter = 0 # Contador de intersecciones
var num_inter = 0 # Número de intersecciones
onready var points = get_tree().get_nodes_in_group("Points")

func _ready():
	set_process(true)
	print("ready")
	print(points)
	
func _process(delta):
	update_points()
	restore_lines()

# points: es un grupo de puntos
func draw_conect_with_everyone(points):
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
				var inter = Calc.intersection(lines[i][0], lines[i][1], lines[j + 1][0], lines[j + 1][1])
				if inter != null:
					draw_circle(inter, 10, Color(0.5, 0.5, 0, 0.5))
					cont_inter += 1
			j += 1
		i += 1
		j = i
	
	num_inter = cont_inter
	cont_inter = 0

func update_points():
	points = get_tree().get_nodes_in_group("Points")
	
func restore_lines():
	lines = []

func show_points_anim(points):
	for i in points:
		i.get_node("anim").play("show")