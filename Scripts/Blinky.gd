extends "res://Scripts/Ghost.gd"

onready var _ghost_home = get_parent().get_node( "GhostHome" )

func _ready():
	_ghost_name = "blinky" # Set the animation


func can_move():
	return true


func get_ghost_path():
	if is_eaten():
		return GhostPath.get_simple_path(position, _ghost_home.position, false)
	else:
		return GhostPath.get_simple_path(position, Player.position, false)


func ghost_path_node_reached():
	pass # Unneeded, path not stored internally
