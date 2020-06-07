extends "res://Scripts/Ghost.gd"


onready var Blinky = get_parent().get_node("Blinky")
onready var _ghost_home = get_parent().get_node( "GhostHome" )

func _ready():
	_ghost_name = "inky"


func can_move():
	return PlayerScore.get_current_score() >= 300


func get_ghost_path():
	if is_eaten():
		return GhostPath.get_simple_path(position, _ghost_home.position, false)
	else:
		var pacman_front = Player.position + Player.direction * 36
		var blinky_pacman_vector = pacman_front - Blinky.position
		var desired_coords = Blinky.position + 2 * blinky_pacman_vector
		
		return GhostPath.get_simple_path(position, desired_coords, false)


func ghost_path_node_reached():
	pass

