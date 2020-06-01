extends "res://Ghost.gd"


var _track_player = false
var _current_path = []
var _path_player = []
var _path_base = []

var _base = Vector2(330, 390)


func _ready():
	_ghost_name = "clyde"


func can_move():
	return PlayerScore.get_current_score() >= 400


func get_ghost_path():
	var player_distance = position.distance_to(Player.position)
	
	if player_distance > 150:
		_track_player = true
	
	if player_distance > 75 and _track_player:
		if _path_player.size() > 1:
			_current_path = _path_player
		else:
			_path_player = GhostPath.get_simple_path(position, Player.position, false)
		
		_path_base = GhostPath.get_simple_path(position, _base, false)
	elif position.distance_to( _base ) > 75:
		if _path_base.size() > 1:
			_track_player = false
			_current_path = _path_base
		else:
			_path_base = GhostPath.get_simple_path(position, _base, false)
			_track_player = true
		
		_path_player = GhostPath.get_simple_path(position, Player.position, false)
	
	return _current_path


func ghost_path_node_reached():
	_current_path.remove(0)
	
	if _track_player:
		_path_player.remove(0)
	else:
		_path_base.remove(0)
