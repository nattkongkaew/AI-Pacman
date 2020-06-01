extends Area2D


signal hit


const SPEED = 100.0


var _direction = Vector2(0, 0)
var _game_enabled = false
var _ghost_path = []
var _vulnerable = false

var _ghost_name = "vulnerable" # Set in _ready in children


onready var Animation = get_node("AnimatedSprite")
onready var GhostPath = get_parent().get_node("GhostPath")
onready var Player = get_parent().get_node("Pacman")
onready var PlayerScore = get_parent().get_node("BoardScoreboard")
onready var Walls = get_parent().get_node("GhostPath/Walls")


func _ready():
	pass


func _physics_process(delta):
	if !can_move():
		return
	
	ghost_move(delta)
	update_animation()


func can_move():
	pass # Implement in children


func game_enabled():
	return _game_enabled


func is_vulnerable():
	return _vulnerable


func set_game_enabled(game_enabled):
	_game_enabled = game_enabled


func set_vulnerable( vulnerable ):
	_vulnerable = vulnerable


func update_animation():
	var anim_name = _ghost_name
	
	if is_vulnerable():
		anim_name = "vulnerable"
	
	if _direction.y > 0 and _direction.y > _direction.x:
		anim_name += "_down"
	elif _direction.y < 0 and _direction.y < _direction.x:
		anim_name += "_up"
	elif _direction.x > 0 and _direction.x > _direction.y:
		anim_name += "right"
	elif _direction.x < 0 and _direction.x < _direction.y:
		anim_name += "left"
	
	Animation.set_animation(anim_name)


func ghost_move(delta):
	_ghost_path = get_ghost_path()
	
	var target_pos = _ghost_path[ 0 ]
	_direction = (target_pos-position).normalized()
	var distance = position.distance_to(target_pos)
	
	if distance > 1:
		position += SPEED * delta * _direction
	else:
		_ghost_path.remove( 0 )
		ghost_path_node_reached()


func get_ghost_path():
	pass # Implement in children


func ghost_path_node_reached():
	pass # Implement in children
