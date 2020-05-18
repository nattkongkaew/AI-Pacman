extends KinematicBody2D

# Initialize direction variable of Pacman as stop (x,y)
var direction = Vector2(0,0)

# Moving speed
var speed = 100

# Play animated sprite as the game start
func _ready():
	$AnimatedSprite.play("moving")

# Function control movement of Pacman
# Function receives input from user, then moves Pacman and change animate sprite accordingly.
# direction callulated by (left - right) for horizontal and (down - up) for vertical movement.
func _process(delta):
	# If user press keyboard "up"
	if Input.is_action_pressed("ui_up"):
		# Direction move toward y=-1 (downward) axis (x,y) 
		direction = Vector2(0,-1)
		# Rotate Pacman animated sprite by -90 degree
		rotation = deg2rad(-90)
		
	# If user press keyboard "down"
	if Input.is_action_pressed("ui_down"):
		# Direction move toward y=1 (upword) axis (x,y) 
		direction = Vector2(0,1)
		# Rotate Pacman animated sprite by 90 degree
		rotation = deg2rad(90)
		
	# If user press keyboard "left"
	if Input.is_action_pressed("ui_left"):
		# Direction move toward x=-1 (left) axis (x,y) 
		direction = Vector2(-1,0)
		# Rotate Pacman animated sprite by 180 degree
		rotation = deg2rad(180)
		
	# If user press keyboard "right"
	if Input.is_action_pressed("ui_right"):
		# Direction move toward x=1 (right) axis (x,y) 
		direction = Vector2(1,0)
		# Rotate Pacman animated sprite by 0 degree
		rotation = deg2rad(0)
		
	# Pacman moves by speed and direction until it collides to the wall
	move_and_collide(speed * direction * delta)
