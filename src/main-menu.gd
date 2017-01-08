extends Node2D

func _ready():
	pass

func _on_start_pressed():
	get_tree().change_scene("res://scenes/main-screens/levels.tscn")
