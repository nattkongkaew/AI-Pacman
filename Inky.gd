extends Area2D

onready var  walls = get_parent().get_node("Navigation2D/Walls")
onready var player_score = get_parent().get_node("BoardScoreboard")
var path = []
var direction = Vector2(0,0)
var SPEED = 100


func _ready():
	position = walls.get_inky_pos()
	path = walls.get_inky_path_to_player()
	pass
	
func _physics_process(delta):

	if(player_score.get_current_score() < 300):
		return
		
	if(path.size() > 1):
		var pos_to_move = path[0]
		direction = (pos_to_move - position).normalized()
		var distance = position.distance_to(path[0])
		if(distance > 1):
			position += SPEED * delta * direction
		else:
			path.remove(0)
	else:
		path = walls.get_inky_path_to_player()
