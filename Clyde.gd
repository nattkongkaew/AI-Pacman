extends KinematicBody2D

onready var speed : = 80.0
onready var Player = get_parent().get_node("Pacman")
onready var GhostPath = get_parent().get_node("GhostPath")
var path_for_ghost = []
var path_to_base = []
var start_position = self.position
var direction = Vector2(0,0)


# Source: https://www.youtube.com/watch?v=2xiE27j4iiw
func _ready():
	position = self.position
	path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)
	path_to_base = GhostPath.get_simple_path(self.position, start_position, false)


func _process(delta):
	if(position.distance_to(Player.position) > 75):
		if(path_for_ghost.size() > 1):
			move_clyde_to_player(delta)
	#	elif(path_for_ghost.size() > 1):
	#		move_clyde_to_base(delta)
		else:
			path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)
		path_to_base = GhostPath.get_simple_path(self.position, start_position, false)
	else:
		if(path_to_base.size() > 1):
			move_clyde_to_base(delta)
	#	elif(path_for_ghost.size() > 1):
	#		move_clyde_to_base(delta)
		else:
			path_to_base = GhostPath.get_simple_path(self.position, start_position, false)
		path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)


func move_clyde_to_player(delta: float) -> void:
	var pos_to_move = path_for_ghost[0]
	direction = (pos_to_move - position).normalized()
	var distance_to_next_pos = position.distance_to(path_for_ghost[0])
	
	if(distance_to_next_pos > 1):
		position += speed * delta * direction
#	elif(distance_to_player > 1):
#		direction = (pos_to_move + position).normalized()
#		position += speed * delta * direction
#		path_for_ghost= GhostPath.get_simple_path(self.position, start_position, false)
#		pos_to_move = path_for_ghost[0]
#		direction = (pos_to_move - position).normalized()
#		distance_to_player = position.distance_to(path_for_ghost[0])
#		position += speed * delta * direction
	else:
		path_for_ghost.remove(0)

func move_clyde_to_base(delta: float) -> void:
	var pos_to_move = path_to_base[0]
	direction = (pos_to_move - position).normalized()
	var distance_to_base = position.distance_to(path_to_base[0])
	
	if(distance_to_base > 1):
		position += speed * delta * direction
	else:
		path_to_base.remove(0)

## Pathfinder source: https://www.youtube.com/watch?v=0fPOt0Jw52s
#func _process(delta: float) -> void:
#	var clyde_move_distance : = speed * delta
#	move_clyde(clyde_move_distance)
#
#
#func move_clyde(distance: float) -> void:
#	var start_position : = position
#
#	move_to_new_point(distance, start_position)
#
#
#func move_to_new_point(distance: float, start_position: Vector2) -> void:
#	for i in range(path.size()):
#		var next_position_distance : = start_position.distance_to(path[0])
#
#		if distance <= next_position_distance and distance >= 0.0:
#			position = start_position.linear_interpolate(path[0], distance / next_position_distance)
#			break
#		elif distance < 0.0:
#			position = path[0]
#			set_process(false)
#			break
#
#		distance -= next_position_distance
#		start_position = find_new_start_position()
#
#
#func find_new_start_position() -> Vector2:
#	var start_position = path[0]
#	path.remove(0)
#
#	return start_position
#
#func set_path(pathValue : PoolVector2Array) -> void:
#	path = pathValue
#	if pathValue.size() == 0:
#		return
#	set_process(true)
#
