extends "res://Ghost.gd"


onready var Blinky = get_parent().get_node("Blinky")


func _ready():
	_ghost_name = "inky"


func can_move():
	return PlayerScore.get_current_score() >= 300


func get_ghost_path():
	var pacman_front = Player.position + Player.direction * 36
	var blinky_pacman_vector = pacman_front - Blinky.position
	var desired_coords = Blinky.position + 2 * blinky_pacman_vector
	
	return GhostPath.get_simple_path(position, desired_coords, false)


func ghost_path_node_reached():
	pass
