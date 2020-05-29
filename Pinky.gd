extends Area2D

signal hit

onready var  walls = get_parent().get_node("GhostPath/Walls")
onready var player_score = get_parent().get_node("BoardScoreboard")
onready var pinky_can_move = false
var path = []
var direction = Vector2(0,0)
var SPEED = 100
var path1 = []
var path2 = []
var path3 = []
var path4 = []

onready var player = get_parent().get_parent().get_node("Pacman")
onready var pinky = get_parent().get_parent().get_node("Pinky")
func _ready():
	position = walls.get_pinky_pos()
	path = walls.get_path_to_player()
	path1 = walls.get_first_path()
	path2 = walls.get_second_path()
	path3 = walls.get_third_path()
	path4 = walls.get_fourth_path()
	pass

	
func _physics_process(delta):
	if(get_pinky_can_move() == false):
		return
	
	if(player_score.get_current_score() < 100):
		return
		
	if(path < path1 and path2 and path3 and path4):
		if(path.size() > 1):
			move_path(delta)
		else:
			path = walls.get_path_to_player()
			path1 = walls.get_first_path()
			path2 = walls.get_second_path()
			path3 = walls.get_third_path()
			path4 = walls.get_fourth_path()
			
			
	elif(path1 < path and path2 and path3 and path4):
		if(path1.size() > 1):
			move_path1(delta)
		else:
			path = walls.get_path_to_player()
			path1 = walls.get_first_path()
			path2 = walls.get_second_path()
			path3 = walls.get_third_path()
			path4 = walls.get_fourth_path()
			
	elif(path2 < path and path1 and path3 and path4):
		if(path2.size() > 1):
			move_path2(delta)
		else:
			path = walls.get_path_to_player()
			path1 = walls.get_first_path()
			path2 = walls.get_second_path()
			path3 = walls.get_third_path()
			path4 = walls.get_fourth_path()
	elif(path3 < path and path1 and path2 and path4):
		if(path3.size() > 1):
			move_path3(delta)
		else:
			path = walls.get_path_to_player()
			path1 = walls.get_first_path()
			path2 = walls.get_second_path()
			path3 = walls.get_third_path()
			path4 = walls.get_fourth_path()
	elif(path4 < path and path1 and path2 and path3):
		if(path4.size() > 1):
			move_path4(delta)
		else:
			path = walls.get_path_to_player()
			path1 = walls.get_first_path()
			path2 = walls.get_second_path()
			path3 = walls.get_third_path()
			path4 = walls.get_fourth_path()
		



func move_path(delta: float) -> void:
	var pos_to_move = path[0]
	direction = (pos_to_move - position).normalized()
	var distance_to_base = position.distance_to(path[0])
	
	if(distance_to_base > 1):
		position += SPEED * delta * direction
	else:
		path.remove(0)
		
func move_path1(delta: float) -> void:
	var pos_to_move1 = path1[0]
	direction = (pos_to_move1 - position).normalized()
	var distance_to_base1 = position.distance_to(path1[0])
	
	if(distance_to_base1 > 1):
		position += SPEED * delta * direction
	else:
		path1.remove(0)
		
func move_path2(delta: float) -> void:
	var pos_to_move2 = path2[0]
	direction = (pos_to_move2 - position).normalized()
	var distance_to_base2 = position.distance_to(path2[0])
	
	if(distance_to_base2 > 1):
		position += SPEED * delta * direction
	else:
		path2.remove(0)
		
func move_path3(delta: float) -> void:
	var pos_to_move3 = path3[0]
	direction = (pos_to_move3 - position).normalized()
	var distance_to_base3 = position.distance_to(path3[0])
	
	if(distance_to_base3 > 1):
		position += SPEED * delta * direction
	else:
		path3.remove(0)
		
func move_path4(delta: float) -> void:
	var pos_to_move4 = path4[0]
	direction = (pos_to_move4 - position).normalized()
	var distance_to_base4 = position.distance_to(path4[0])
	
	if(distance_to_base4 > 1):
		position += SPEED * delta * direction
	else:
		path4.remove(0)


func get_pinky_can_move():
	return pinky_can_move


func set_pinky_can_move(can_move):
	pinky_can_move = can_move
