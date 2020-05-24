extends TileMap


onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("Pacman")
onready var blinky = get_parent().get_parent().get_node("Blinky")
onready var inky = get_parent().get_parent().get_node("Inky")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
onready var walls = get_parent().get_node("Walls")

# Get Blinky position
func get_blinky_pos():
	var pos = map_to_world(Vector2(16,19))
	pos.y += half_cell_size.y
	return pos

# Get Pacman position
func get_player_pos():
	return player.position

#get Inky position
func get_inky_pos():
	return inky.position

# Get path from Blinky position to Pacman position
func get_blinky_path_to_player():
	var path = get_parent().get_simple_path(blinky.position, player.position, false)
	return path

# Get path from Inky to Pacman
func get_inky_path_to_player():
	var desired_coords = player.position	
	var direction = blinky.position.direction_to(player.position).normalized()

	if(direction.x == 0):
		desired_coords.x = desired_coords.x
	elif(direction.x < 0):
		desired_coords.x = desired_coords.x-32
	else:
		desired_coords.x = desired_coords.x+32

	if(direction.y == 0):
		desired_coords.y = desired_coords.y
	elif(direction.y < 0):
		desired_coords.y = desired_coords.y-32
	else:
		desired_coords.y = desired_coords.y+32
	
	var path = get_parent().get_simple_path(inky.position, desired_coords, false)
	return path
