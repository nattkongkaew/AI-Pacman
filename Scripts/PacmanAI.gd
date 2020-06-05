extends KinematicBody2D

var direction = Vector2(0,0)
var speed = 110
onready var move_pacman = false
onready var Board = get_parent()
onready var GameOverScreen = get_parent().get_node("GameOver")
onready var walls = get_parent().get_node("Walls")
onready var Blinky = get_parent().get_node( "Blinky" )
onready var Pinky = get_parent().get_node( "Pinky" )
onready var Inky = get_parent().get_node( "Inky" )
onready var Clyde = get_parent().get_node( "Clyde" )
onready var Pellets = walls.pellet_child
const MAX_GHOST_DIST_PRE_FLEE = 92

# path before moving on to the next one
const POINT_RADIUS = 5
signal WHISTLE
# Path that the sidekick must follow - undefined by default
var path
var velocity = Vector2()

func _ready():
	$AnimatedSprite.play("moving")

func _process(_delta):
	var pellets = walls.get_pellet_child( Pellets )
	
	var target_pos = get_closest_pellet( pellets )
	
	path = walls.get_astar_path( position, target_pos )
	# If we got a path...
	if path:
		# Remove the first point 
		path.remove(0)
	
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


func get_closest_pellet( pellets ):
	var min_dist = 99999
	var min_pellet
	var min_free_dist = 99999
	var min_free_pellet
	for pellet in pellets:
		var dist = position.distance_to(pellet)
		if (dist < min_dist):
			min_dist = dist
			min_pellet = pellet
			
		if Blinky.is_vulnerable() and not Blinky.is_eaten():
			var target_ghost = Blinky.position
			var gdist = position.distance_to( target_ghost )
			var blinky_block = !Blinky.is_vulnerable() and blocked_by_ghost( target_ghost, Blinky )
			var pinky_block = !Pinky.is_vulnerable() and blocked_by_ghost( target_ghost, Pinky )
			var inky_block = !Inky.is_vulnerable() and blocked_by_ghost( target_ghost, Inky )
			var clyde_block = !Clyde.is_vulnerable() and blocked_by_ghost( target_ghost, Clyde )
			
			if gdist < min_free_dist and !blinky_block and !pinky_block and !inky_block and !clyde_block:
				min_free_dist = gdist
				min_free_pellet = target_ghost
			
			if gdist < min_dist:
				min_dist = gdist
				min_pellet = target_ghost
			
		if Pinky.is_vulnerable() and not Pinky.is_eaten():
			var target_ghost = Pinky.position
			var gdist = position.distance_to( target_ghost )
			var blinky_block = !Blinky.is_vulnerable() and blocked_by_ghost( target_ghost, Blinky )
			var pinky_block = !Pinky.is_vulnerable() and blocked_by_ghost( target_ghost, Pinky )
			var inky_block = !Inky.is_vulnerable() and blocked_by_ghost( target_ghost, Inky )
			var clyde_block = !Clyde.is_vulnerable() and blocked_by_ghost( target_ghost, Clyde )
			
			if gdist < min_free_dist and !blinky_block and !pinky_block and !inky_block and !clyde_block:
				min_free_dist = gdist
				min_free_pellet = target_ghost
			
			if gdist < min_dist:
				min_dist = gdist
				min_pellet = target_ghost
			
		if Inky.is_vulnerable() and not Inky.is_eaten():
			var target_ghost = Inky.position
			var gdist = position.distance_to( target_ghost )
			var blinky_block = !Blinky.is_vulnerable() and blocked_by_ghost( target_ghost, Blinky )
			var pinky_block = !Pinky.is_vulnerable() and blocked_by_ghost( target_ghost, Pinky )
			var inky_block = !Inky.is_vulnerable() and blocked_by_ghost( target_ghost, Inky )
			var clyde_block = !Clyde.is_vulnerable() and blocked_by_ghost( target_ghost, Clyde )
			
			if gdist < min_free_dist and !blinky_block and !pinky_block and !inky_block and !clyde_block:
				min_free_dist = gdist
				min_free_pellet = target_ghost
			
			if gdist < min_dist:
				min_dist = gdist
				min_pellet = target_ghost
			
		if Clyde.is_vulnerable() and not Clyde.is_eaten():
			var target_ghost = Clyde.position
			var gdist = position.distance_to( target_ghost )
			var blinky_block = !Blinky.is_vulnerable() and blocked_by_ghost( target_ghost, Blinky )
			var pinky_block = !Pinky.is_vulnerable() and blocked_by_ghost( target_ghost, Pinky )
			var inky_block = !Inky.is_vulnerable() and blocked_by_ghost( target_ghost, Inky )
			var clyde_block = !Clyde.is_vulnerable() and blocked_by_ghost( target_ghost, Clyde )
			
			if gdist < min_free_dist and !blinky_block and !pinky_block and !inky_block and !clyde_block:
				min_free_dist = gdist
				min_free_pellet = target_ghost
			
			if gdist < min_dist:
				min_dist = gdist
				min_pellet = target_ghost
		
		if blocked_by_ghost( pellet, Blinky ) or blocked_by_ghost( pellet, Pinky ) or blocked_by_ghost( pellet, Inky ) or blocked_by_ghost( pellet, Clyde ):
			continue
		if dist < min_free_dist:
			min_free_dist = dist
			min_free_pellet = pellet
	#print(min_pellet)
	if min_free_pellet:
		return min_free_pellet
	return min_pellet


func blocked_by_ghost( pellet, ghost ):
	var dir_to_pellet = pellet - position
	var dir_to_ghost = ghost.position - position
	var ghost_to_pellet = ghost.position - pellet
	var projected = dir_to_pellet.dot( dir_to_ghost ) / dir_to_pellet.length_squared()
	
	var flee_from_ghost_near_pellet = ghost_to_pellet.length_squared() < MAX_GHOST_DIST_PRE_FLEE * MAX_GHOST_DIST_PRE_FLEE
	#return projected < 1 or ghost_to_pellet.length_squared() < MAX_GHOST_DIST_PRE_FLEE
	return flee_from_ghost_near_pellet

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
