extends Area2D

onready var  walls = get_parent().get_node("GhostPath/Walls")
onready var blinky_animation = get_node("AnimatedSprite")
onready var blinky_can_move = false
var path = []
var direction = Vector2(0,0)
var SPEED = 100


func _ready():
	position = walls.get_blinky_pos()
	path = walls.get_blinky_path_to_player()

# Blinky movement function
func _physics_process(delta):
	if(get_blinky_can_move() == false):
		return
	
	blinky_animation()
	
	if(path.size() > 1):
		var pos_to_move = path[0]
		direction = (pos_to_move - position).normalized()
		var distance = position.distance_to(path[0])
		if(distance > 1):
			position += SPEED * delta * direction
		else:
			path.remove(0)
	else:
		path = walls.get_blinky_path_to_player()

# Change Blinky sprite accoring to its diection.
func blinky_animation():
	if(direction.y > 0 and direction.y > direction.x):
		blinky_animation.set_animation("down")
	if(direction.y < 0 and direction.y < direction.x):
		blinky_animation.set_animation("up")
	if(direction.x > 0 and direction.x > direction.y):
		blinky_animation.set_animation("right")
	if(direction.x < 0 and direction.x < direction.y):
		blinky_animation.set_animation("left")


func get_blinky_can_move():
	return blinky_can_move


func set_blinky_can_move(can_move):
	blinky_can_move = can_move
