extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 100
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")

func _ready():
	$AnimatedSprite.play("moving")

func _process(delta):
	if(get_move_pacman() == true):
		if Input.is_action_pressed("ui_up"):
			direction = Vector2(0,-1)
			rotation = deg2rad(-90)
		if Input.is_action_pressed("ui_down"):
			direction = Vector2(0,1)
			rotation = deg2rad(90)
		if Input.is_action_pressed("ui_left"):
			direction = Vector2(-1,0)
			rotation = deg2rad(180)
		if Input.is_action_pressed("ui_right"):
			direction = Vector2(1,0)
			rotation = deg2rad(0)
		
	move_and_slide(speed * direction)


func set_move_pacman(can_move):
	move_pacman = can_move
	


func get_move_pacman():
	return move_pacman


#func _on_Clyde_body_entered(body):
#	if(body == self):
#		speed = 0
#		hide()
#		GameOverScreen.show()
#		Board.end_game()
#
#
#func _on_Inky_body_entered(body):
#	if(body == self):
#		speed = 0
#		hide()
#		GameOverScreen.show()
#		Board.end_game()
#
#
#func _on_Blinky_body_entered(body):
#	if(body == self):
#		speed = 0
#		hide()
#		GameOverScreen.show()
#		Board.end_game()
#
#
#func _on_Pinky_body_entered(body):
#	if(body == self):
#		Board.end_game()
