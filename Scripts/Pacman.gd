extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 110
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")
onready var Clyde = get_parent().get_node("Clyde")
onready var Inky = get_parent().get_node("Inky")
onready var Blinky = get_parent().get_node("Blinky")
onready var Pinky = get_parent().get_node("Pinky")

func _ready():
	$AnimatedSprite.play("moving")

func _process(_delta):
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


func _on_Clyde_body_entered(body):

	if(body == self):
		if Clyde.is_vulnerable():
			Clyde.set_eaten(true)
		else:
			speed = 0
			hide()
			GameOverScreen.show()
			Board.game_lost()


func _on_Inky_body_entered(body):

	if(body==self):
		if Inky.is_vulnerable():
			Inky.set_eaten(true)
		else:
			speed = 0
			hide()
			GameOverScreen.show()
			Board.game_lost()


func _on_Blinky_body_entered(body):

	if(body==self):
		if Blinky.is_vulnerable():
			Blinky.set_eaten(true)
		else:
			speed = 0
			hide()
			GameOverScreen.show()
			Board.game_lost()


func _on_Pinky_body_entered(body):
	
	if(body == self):
		if Pinky.is_vulnerable():
			Pinky.set_eaten(true)
		else:
			speed = 0
			hide()
			GameOverScreen.show()
			Board.game_lost()
