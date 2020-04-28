extends Area2D


var direction = Vector2(0,0)
var speed = 100

func _ready():
	$AnimatedSprite.play("moving")

func _process(delta):
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
		
	position += speed * direction * delta
