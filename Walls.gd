extends TileMap

onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("Pacman")
onready var inky = get_parent().get_parent().get_node("Inky")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
onready var walls = get_parent().get_node("Walls")

func get_inky_pos():
	var inky_pos = map_to_world(Vector2(16,19))
	inky_pos.y += half_cell_size.y
	return inky_pos

func get_path_to_player():
	var inky_path = get_parent().get_simple_path(inky.position, player.position, false)
	return inky_path


