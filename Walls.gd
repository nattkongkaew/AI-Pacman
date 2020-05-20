extends TileMap


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_parent().get_node("Pacman")
onready var enemy = get_parent().get_parent().get_node("Pinky")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
onready var walls = get_parent().get_node("Walls")

func get_enemy_pos():
	var pos = map_to_world(Vector2(16,19))
	pos.y += half_cell_size.y
	return pos

func get_path_to_player():
	var path = get_parent().get_simple_path(enemy.position, player.position, false)
	return path
