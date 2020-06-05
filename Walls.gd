extends TileMap


onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_node("Pacman")
onready var blinky = get_parent().get_node("Blinky")
onready var inky = get_parent().get_node("Inky")
onready var pinky = get_parent().get_node("Pinky")
onready var clyde = get_parent().get_node("Clyde")
onready var walls = get_parent().get_node("Walls")
onready var fruitpath = get_node("FruitSpawnPath/FruitSpawnLocation")
onready var fruit = get_node("Fruit")
onready var fruit_animation = fruit.get_node("AnimatedSprite")
onready var scoreboard = get_parent().get_node("BoardScoreboard")
onready var tunnel1 = get_parent().get_node("Tunnel1")
onready var tunnel2 = get_parent().get_node("Tunnel2")

onready var astar = AStar.new()
onready var used_rect = get_used_rect()
onready var movable_tile = get_used_cells_by_id(50)  #50 is the index of tile that have navigation polygon --refer to tileset
onready var pellet_child = get_node("Pellets")
onready var _half_cell_size = cell_size / 2

var vulnerable = 0
var vulnerable_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	#add tiles to the navigation grid
	astar_add_walkable_tiles(movable_tile)
	#connect all tiles
	astar_connect_walkable_tiles(movable_tile)


func _process(delta):
	get_pellet_child(pellet_child)
	if(vulnerable == 1):
		run_vulnerable(delta)

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

func astar_add_walkable_tiles(movable_tile):
	# Loop over all tiles
	for tile in movable_tile:

		# Determine the ID of the tile
		var id = _get_id_for_point(tile)

		# Add the tile to the AStar navigation
		# NOTE: We use Vector3 as AStar is, internally, 3D. We just don't use Z.
		astar.add_point(id, Vector3(tile.x, tile.y, 0))

	
func astar_connect_walkable_tiles(movable_tile):
	# Loop over all tiles
	for tile in movable_tile:

		# Determine the ID of the tile
		var id = _get_id_for_point(tile)

		# Loops used to search around player (range(3) returns 0, 1, and 2)
		for x in range(3):
			for y in range(3):

				# Determines target, converting range variable to -1, 0, and 1
				var target = tile + Vector2(x - 1, y - 1)

				# Determines target ID
				var target_id = _get_id_for_point(target)

				# Do not connect if point is same or point does not exist on astar
				if tile == target or not astar.has_point(target_id):
					continue

				# Connect points
				astar.connect_points(id, target_id, true)

func get_astar_path(start, end):
	# Convert positions to cell coordinates
	var start_tile = world_to_map(start)
	var end_tile = world_to_map(end)

	# Determines IDs
	var start_id = _get_id_for_point(start_tile)
	var end_id = _get_id_for_point(end_tile)

	# Return null if navigation is impossible
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null

	# Otherwise, find the map
	var path_map = astar.get_point_path(start_id, end_id)

	# Convert Vector3 array
	var path_world = []
	for point in path_map:
		var point_world = map_to_world(Vector2(point.x, point.y)) + _half_cell_size
		path_world.append(point_world)
	return path_world

# Determines a unique ID for a given point on the map
func _get_id_for_point(point):

	# Offset position of tile with the bounds of the tilemap
	# This prevents ID's of less than 0
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y

	# Returns the unique ID for the point on the map
	return x + y * used_rect.size.x


# get all node position and store in pellet_point
func get_pellet_child(pellet_child):
	var pellet_point=[]
	for N in pellet_child.get_children():
		if N.get_child_count()>0:
			var point = N.position
			pellet_point.append(point)
			#print(point)
			#print(N.get_name())
			get_pellet_child(N)
	return pellet_point
	#for x in pellet_point:
	#	print(x)
