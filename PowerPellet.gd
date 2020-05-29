extends Area2D

signal power_pellet_collected

func _ready():
	pass


func _on_PowerPellet_body_entered(body: Node) -> void:
	emit_signal("power_pellet_collected")
	queue_free()
