extends "res://Ghost.gd"


func _ready():
	_ghost_name = "blinky" # Set the animation


func can_move():
	return true


func get_ghost_path():
	return GhostPath.get_simple_path(position, Player.position, false)


func ghost_path_node_reached():
	pass # Unneeded, path not stored internally
