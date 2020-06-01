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

var vulnerable = 0
var vulnerable_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func _process(delta):
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
