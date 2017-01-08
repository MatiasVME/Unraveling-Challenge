extends Node

const RES_X = 1280
const RES_Y = 720

var current_level = 1 setget set_current_level, get_current_level

var point_for_level = {
		level_1 = 4,
		level_2 = 5
	}

# Setters
#

func set_current_level(p_current_level):
	current_level = p_current_level

# Getters
#

func get_current_level():
	return current_level
	
