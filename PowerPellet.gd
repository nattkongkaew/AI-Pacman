extends Area2D

signal power_pellet_collected
onready var BoardScoreboard = get_parent().get_parent().get_parent().get_node("BoardScoreboard")

func _ready():
	pass


func _on_PowerPellet_body_entered(_body: Node) -> void:
	emit_signal("power_pellet_collected")
	BoardScoreboard.add_score(40)
	queue_free()
