extends Area2D

onready var  walls = get_parent().get_node("GhostPath/Walls")
onready var player_score = get_parent().get_node("BoardScoreboard")
onready var inky_animation = get_node("AnimatedSprite")
var path = []
var direction = Vector2(0,0)
var SPEED = 100


func _ready():
	position = walls.get_inky_pos()
	path = walls.get_inky_path_to_player()
	pass
	
func _physics_process(delta):
	
	inky_animation()
	
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

func inky_animation():
	if(direction.y > 0 and direction.y > direction.x):
		inky_animation.set_animation("down")
	if(direction.y < 0 and direction.y < direction.x):
		inky_animation.set_animation("up")
	if(direction.x > 0 and direction.x > direction.y):
		inky_animation.set_animation("right")
	if(direction.x < 0 and direction.x < direction.y):
		inky_animation.set_animation("left")
