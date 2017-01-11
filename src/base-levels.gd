extends Node2D

onready var res_point = load("res://scenes/point.tscn")
onready var lab_inter = get_node("num_inter")

func _ready():
	set_process(true)
	randomize()
	
	var num_points = global.point_for_level["level_1"]
	var current_points = 0
	
	# Instancia y posiciona los puntos aleatoriamente
	while(current_points <= num_points):
		var instance_point = res_point.instance()
		add_child(instance_point)
		instance_point.add_to_group("Points")
		var pos_x = rand_range(0 + 100, global.RES_X - 100)
		var pos_y = rand_range(0 + 100, global.RES_Y - 100)
		instance_point.set_pos(Vector2(pos_x, pos_y))
		
		current_points += 1
		
		print(current_points, ": ", instance_point.get_pos().x, ", ", instance_point.get_pos().y)

func _process(delta):
	update()
	pass

func _draw():
	#draw_line(Vector2(100, 100), Vector2(200, 200), Color(1,0,0), 5)
	#draw_line(Vector2(200, 100), get_global_mouse_pos(), Color(1,1,0), 5)
	#draw_circle(Vector2(150, 150), 10, Color(0,1,1))
	
	#var inter = calc.intersection(Vector2(100, 100), Vector2(200, 200), Vector2(200, 100), get_global_mouse_pos())
	#print(inter.x, ", ", inter.y)
	#if inter != null:
	#	draw_circle(inter, 8, Color(1, 0, 0))
	
	if global.get_current_level() == 1:
		_level(1)

func _level(level):
	if level == 1:
		var points = get_tree().get_nodes_in_group("Points")
		
		var lines = [] 
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
		
		i = 0
		j = 0
		
		# Muestra las colisiones
		var num_inter = 0
		
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
		
		lab_inter.set_text(str(num_inter))
		num_inter = 0