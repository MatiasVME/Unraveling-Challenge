extends Node2D

var black_opacity = 0.0
onready var black_img = get_node("BlackImg")

func _ready():
	set_process(true)

func _process(delta):
	if black_opacity <= 1.0:
		black_opacity += delta * 0.5
		black_img.set_opacity(black_opacity)

func _on_ExitSplash_timeout():
	get_tree().change_scene("res://src/MainScreens/Menu.tscn")
