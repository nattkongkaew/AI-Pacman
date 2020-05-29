extends TileMap


onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("Pacman")
onready var blinky = get_parent().get_parent().get_node("Blinky")
onready var inky = get_parent().get_parent().get_node("Inky")
onready var pinky = get_parent().get_parent().get_node("Pinky")
onready var clyde = get_parent().get_parent().get_node("Clyde")
onready var walls = get_parent().get_node("Walls")
onready var fruitpath = get_node("FruitSpawnPath/FruitSpawnLocation")
onready var fruit = get_node("Fruit")
onready var fruit_animation = fruit.get_node("AnimatedSprite")
onready var scoreboard = get_parent().get_parent().get_node("BoardScoreboard")
onready var tunnel1 = $Tunnel1
onready var tunnel2 = $Tunnel2

var vulnerable = 0
var vulnerable_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass # Replace with function body.

func _process(delta):

	if(vulnerable == 1):
		run_vulnerable(delta)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

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
	

func get_pinky_pos():
	return pinky.position

func get_path_to_base(pos: Vector2, s_pos: Vector2):
	var base_path = get_parent().get_simple_path(pos, s_pos)
	return base_path

func get_path_to_player():
	var path = get_parent().get_simple_path(pinky.position,player.position + Vector2(116,0), false)
	return path

func get_first_path():
	var path = get_parent().get_simple_path(pinky.position,player.position + Vector2(72,0) , false)
	return path

func get_second_path():
	var path = get_parent().get_simple_path(pinky.position,player.position + Vector2(-72,0) , false)
	return path

func get_third_path():
	var path = get_parent().get_simple_path(pinky.position,player.position + Vector2(0,72) , false)
	return path

func get_fourth_path():
	var path = get_parent().get_simple_path(pinky.position,player.position + Vector2(0,-72) , false)
	return path

func set_vulnerability() -> void:
	vulnerable = 1

func run_vulnerable(delta) -> void:
	if(vulnerable_time < 5):
		vulnerable_time = vulnerable_time + delta

	else:
		reengage_ghosts()

func reengage_ghosts() -> void:
	vulnerable = 0
	pinky.reengage()
	blinky.reengage()
	inky.reengage()
	clyde.reengage()
	vulnerable_time = 0

func generate_fruit():
	
	fruitpath.set_offset(randi())
	fruit.position = fruitpath.position
	
	var rand_animation = randi()%3+1
	
	if(rand_animation == 1):
		fruit_animation.set_animation("cherry")
	elif(rand_animation == 2):
		fruit_animation.set_animation("orange")
	else:
		fruit_animation.set_animation("strawberry")


func _on_Tunnel2Area2D_body_entered(_body):
	player.position = Vector2(16,19)


func _on_Tunnel1Area2D_body_entered(_body):
	player.position = Vector2(16,19)
