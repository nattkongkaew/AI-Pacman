extends "res://Ghost.gd"

onready var _ghost_home = get_parent().get_node( "GhostHome" )

func _ready():
	_ghost_name = "pinky"


func can_move():
	return PlayerScore.get_current_score() >= 100


func get_ghost_path():
	if is_eaten():
		return GhostPath.get_simple_path(position, _ghost_home.position, false)
	else:
		return GhostPath.get_simple_path(position, Player.position + Player.direction * 72, false)


func ghost_path_node_reached():
	pass
