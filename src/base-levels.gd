extends Node2D

onready var res_point = load("res://scenes/point.tscn")

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

func _draw():
	if global.get_current_level() == 1:
		_level(1)

func _level(level):
	if level == 1:
		var points = get_tree().get_nodes_in_group("Points")
		
		var i = 0
		var j = 0
		
		while i < points.size():
			while j <= points.size():
				if j < points.size() - 1:
					draw_line(points[i].get_pos(), points[j + 1].get_pos(), Color(0.5, 0, 0.5), 5)
				j += 1
			i += 1
			j = i