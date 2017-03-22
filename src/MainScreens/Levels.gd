extends Node2D

func _ready():
	pass

func _on_Level1_pressed():
	get_tree().change_scene("res://src/Levels/Level1.tscn")
