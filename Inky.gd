extends KinematicBody2D

onready var  walls = get_parent().get_node("GhostPath/Walls")
var path = []
var direction = Vector2(0,0)
var SPEED = 50

func _ready():
	position = walls.get_inky_pos()
	path = walls.get_path_to_player()
	
func _physics_process(delta):
	if(path.size() > 1):
		var pos_to_move = path[0]
		direction = (pos_to_move - position).normalized()
		var distance = position.distance_to(path[0])
		if(distance > 1):
			position += SPEED * delta * direction
		else:
			path.remove(0)
	else:
		path = walls.get_path_to_player()
