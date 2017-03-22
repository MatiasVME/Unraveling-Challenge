extends "LevelBase.gd"

func _ready():
	set_process(true)
	show_points_anim(points)

func _process(delta):
	update()

func _draw():
	draw_conect_with_everyone(points)
	show_collision()
