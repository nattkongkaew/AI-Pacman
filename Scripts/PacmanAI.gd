extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 100
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")
onready var walls = get_parent().get_node("Walls")

# path before moving on to the next one
const POINT_RADIUS = 5
signal WHISTLE
# Path that the sidekick must follow - undefined by default
var path
var velocity = Vector2()

func _ready():
	$AnimatedSprite.play("moving")

func _process(_delta):
	emit_signal("WHISTLE")
	
	# Only do stuff if we have a current path
	if path and get_move_pacman():
		# The next point is the first member of the path array
		var target = path[0]
		var MASS = 2.0
		# Determine direction pacman have to move
		var desired_velocity = (target - position).normalized() * speed
		var steering = desired_velocity - velocity
		velocity += steering / MASS
		rotation = velocity.angle()
		
		# Move pacman
		position += velocity * _delta
		
		# If pacman have reached the point
		if position.distance_to(target) < POINT_RADIUS:
			# Remove first path point
			path.remove(0)
			# If we have no points left, remove path
			if path.size() == 0:
				path = null


func set_move_pacman(can_move):
	move_pacman = can_move
	


func get_move_pacman():
	return move_pacman


func _on_Clyde_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.game_lost()


func _on_Inky_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.game_lost()


func _on_Blinky_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.game_lost()


func _on_Pinky_body_entered(body):
	if(body == self):
		speed = 0
		hide()
		GameOverScreen.show()
		Board.game_lost()
