extends Area2D

signal hit

onready var speed = 100.0
onready var PlayerScore = get_parent().get_node("BoardScoreboard")
onready var Player = get_parent().get_node("Pacman")
onready var GhostPath = get_parent().get_node("GhostPath")
onready var Walls = get_parent().get_node("GhostPath/Walls")
onready var AnimateClyde = get_node("ClydeAnimation")
onready var base = Vector2(330, 390)

var vulnerable = 0
onready var clyde_can_move = false
var path_for_ghost = []
var path_to_base = []
var direction = Vector2(0,0)
var track_player = true

# Source: https://www.youtube.com/watch?v=2xiE27j4iiw
func _ready():
	position = self.position
	path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)
	path_to_base = GhostPath.get_simple_path(self.position, base, false)


func _process(delta):
	if(get_clyde_can_move() == false):
		return
		
	if(PlayerScore.get_current_score() < 400):
		return
	
	if(position.distance_to(Player.position) > 150):
		track_player = true
	
	change_clyde_animation()
	
	if(position.distance_to(Player.position) > 75 and track_player == true):
		if(path_for_ghost.size() > 1):
			move_clyde_to_player(delta)
		else:
			path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)
		path_to_base = GhostPath.get_simple_path(self.position, base, false)
	elif(position.distance_to(base) > 75):
		if(path_to_base.size() > 1):
			track_player = false
			move_clyde_to_base(delta)
		else:
			path_to_base = GhostPath.get_simple_path(self.position, base, false)
			track_player = true
		path_for_ghost = GhostPath.get_simple_path(self.position, Player.position, false)


func move_clyde_to_player(delta: float) -> void:
	var pos_to_move = path_for_ghost[0]
	direction = (pos_to_move - position).normalized()
	var distance_to_next_pos = position.distance_to(path_for_ghost[0])
	
	if(distance_to_next_pos > 1):
		position += speed * delta * direction
	else:
		path_for_ghost.remove(0)

func move_clyde_to_base(delta: float) -> void:	
	var pos_to_move = path_to_base[0]
	direction = (pos_to_move - position).normalized()
	var distance_to_base = position.distance_to(path_to_base[0])
	
	if(distance_to_base > 1):
		position += speed * delta * direction
	else:
		path_to_base.remove(0)


func change_clyde_animation():
	if(vulnerable == 1):
		AnimateClyde.set_animation("vulnerable")
	else:
		if(direction.y > 0 and direction.y > direction.x):
			AnimateClyde.set_animation("down")
		if(direction.y < 0 and direction.y < direction.x):
			AnimateClyde.set_animation("up")
		if(direction.x > 0 and direction.x > direction.y):
			AnimateClyde.set_animation("right")
		if(direction.x < 0 and direction.x < direction.y):
			AnimateClyde.set_animation("left")
		
func go_vulnerable() -> void:
	vulnerable = 1
	
func reengage() -> void:
	vulnerable = 0
	if(direction.y > 0 and direction.y > direction.x):
		AnimateClyde.set_animation("down")
	if(direction.y < 0 and direction.y < direction.x):
		AnimateClyde.set_animation("up")
	if(direction.x > 0 and direction.x > direction.y):
		AnimateClyde.set_animation("right")
	if(direction.x < 0 and direction.x < direction.y):
		AnimateClyde.set_animation("left")


func get_clyde_can_move():
	return clyde_can_move


func set_clyde_can_move(can_move):
	clyde_can_move = can_move
