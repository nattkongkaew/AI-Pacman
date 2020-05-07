extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Pellet_body_entered(body: Node) -> void:
	queue_free()
