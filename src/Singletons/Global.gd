extends Node

const RES_X = 1280
const RES_Y = 720

var current_level = 3
var player_move = false

var levels = {
		level_1 = {
			points = 4,
			min_inter = 0
		},
		level_2 = {
			points = 5,
			min_inter = 1
		},
		level_3 = {
			points = 6,
			min_inter = 3
		},
	}
