extends TileMap


onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("PacmanAI")
onready var walls = get_parent().get_node("Walls")
onready var fruitpath = get_node("FruitSpawnPath/FruitSpawnLocation")
onready var fruit = get_node("Fruit")
onready var fruit_animation = fruit.get_node("AnimatedSprite")
onready var scoreboard = get_parent().get_parent().get_node("BoardScoreboard")
onready var tunnel1 = $Tunnel1
onready var tunnel2 = $Tunnel2
onready var pellet = get_node("Pellets").get_node("Pellet7")
onready var start_position = self.position

onready var astar_node = AStar.new()
export(Vector2) var map_size = Vector2(26,30)
var _point_path = []
var _half_cell_size = Vector2()
onready var movable_tile = get_used_cells_by_id(50)  #50 is the index of tile that have navigation polygon --refer to tileset

var path_start_position = Vector2() setget _set_path_start_position
var path_end_position = Vector2() setget _set_path_end_position

var vulnerable = 0
var vulnerable_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	get_pellet_pos()
	print(pellet.position) 
	print(player.position)
	var walkable_cells_list = astar_add_walkable_cells(movable_tile)
	astar_connect_walkable_cells(walkable_cells_list)

	
func astar_add_walkable_cells(movable_tile = []):
	var points_array = []
	print(movable_tile)
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x,y)
			if point in movable_tile:
				point = Vector2(x,y)
				points_array.append(point)
				var point_index = calculate_point_index(point)
				astar_node.add_point(point_index, Vector3(point.x, point.y, 0.0))
	return points_array
	
func astar_connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		var points_relative = PoolVector2Array([
			point + Vector2.RIGHT,
			point + Vector2.LEFT,
			point + Vector2.DOWN,
			point + Vector2.UP,
		])
		for point_relative in points_relative:
			var point_relative_index = calculate_point_index(point_relative)
			if is_outside_map_bounds(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			# If you set this value to false, it becomes a one-way path.
			astar_node.connect_points(point_index, point_relative_index, false)
			


func calculate_point_index(point):
	return point.x + map_size.x * point.y

func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y

func get_astar_path(world_start, world_end):
	player.position = world_to_map(world_start)
	pellet.position = world_to_map(world_end)
	_recalculate_path()
	var path_world = []
	for point in _point_path:
		var point_world = map_to_world(Vector2(point.x, point.y)) + _half_cell_size
		path_world.append(point_world)
	return path_world

func _recalculate_path():
	var start_point_index = calculate_point_index(path_start_position)
	var end_point_index = calculate_point_index(path_end_position)
	_point_path = astar_node.get_point_path(start_point_index, end_point_index)
	update()
	

# Setters for the start and end path values.
func _set_path_start_position(value):
	#if value not in movable_tile:
	#	return
	if is_outside_map_bounds(value):
		return

	set_cell(path_start_position.x, path_start_position.y, -1)
	set_cell(value.x, value.y, 1)
	path_start_position = value
	if path_end_position and path_end_position != path_start_position:
		_recalculate_path()

func _set_path_end_position(value):
	#if value not in movable_tile:
	#	return
	if is_outside_map_bounds(value):
		return

	set_cell(path_start_position.x, path_start_position.y, -1)
	set_cell(value.x, value.y, 2)
	path_end_position = value
	if path_start_position != value:
		_recalculate_path()



func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

# Get Blinky position

# Get pellet7 position
func get_pellet_pos():
	return pellet.position


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
	
