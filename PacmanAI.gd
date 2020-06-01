extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 100
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")
onready var walls = get_parent().get_node("GhostPath/WallsAI")

var path = []
var _path = []

var _target_point_world = Vector2()
var _target_position = Vector2()

var _velocity = Vector2()

func _ready():
	$AnimatedSprite.play("moving")

func _process(delta):
	_target_position = walls.get_pellet_pos()
	var _arrived_to_next_point = _move_to(_target_point_world)
	if _arrived_to_next_point:
		_path.remove(0)
		_target_point_world = _path[0]

func _move_to(world_position):
	var MASS = 10.0
	var ARRIVE_DISTANCE = 10.0

	var desired_velocity = (world_position - position).normalized() * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / MASS
	position += _velocity * get_process_delta_time()
	rotation = _velocity.angle()
	return position.distance_to(world_position) < ARRIVE_DISTANCE





func set_move_pacman(can_move):
	move_pacman = can_move
	


func get_move_pacman():
	return move_pacman


func _on_Clyde_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.end_game()


func _on_Inky_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.end_game()


func _on_Blinky_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.end_game()


func _on_Pinky_body_entered(body):
	if(body == self):
		Board.end_game()


