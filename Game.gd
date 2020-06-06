extends Node2D


onready var PlayerBoard = get_node("Player-Board")
onready var AIBoard = get_node("AI-Board")
onready var NewGameTimer = get_node("NewGameTimer")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerBoard.end_game == true and AIBoard.end_game == true:
		NewGameTimer.start()
		PlayerBoard.end_game = false
		AIBoard.end_game = false


func _on_NewGameTimer_timeout():
	get_tree().reload_current_scene()
