extends KinematicBody2D


onready var pacman_player = get_parent().get_node("Pacman")

var player_position

var motion = Vector2()

func _physics_process(delta):
# Pacman position and Pinky position
	if pacman_player.position.x < position.x:
		motion.x = -100
	if pacman_player.position.x > position.x:
		motion.x = +100
	if pacman_player.position.y < position.y:
		motion.y = -100
	if pacman_player.position.y > position.y:
		motion.y = +100
	motion = move_and_slide(motion, motion)
