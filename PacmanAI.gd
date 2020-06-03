extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 100
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")
onready var walls = get_parent().get_node("GhostPath/WallsAI")


# path before moving on to the next one
const POINT_RADIUS = 5

signal WHISTLE

# Path that the sidekick must follow - undefined by default
var path

var velocity = Vector2()


# Performed on each step
func _process(delta):
	
	#testing by press spacebar
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("WHISTLE")
	# Only do stuff if we have a current path
	if path:

		# The next point is the first member of the path array
		var target = path[0]

		var MASS = 5.0
		# Determine direction pacman have to move
		var desired_velocity = (target - position).normalized() * speed
		var steering = desired_velocity - velocity
		velocity += steering / MASS
		
		# Move pacman
		position += velocity * delta
		

		# If pacman have reached the point
		if position.distance_to(target) < POINT_RADIUS:

			# Remove first path point
			path.remove(0)

			# If we have no points left, remove path
			if path.size() == 0:
				path = null
