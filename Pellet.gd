extends Area2D


signal pellet_collected( score )

const COLLECTION_SCORE = 10


# Called when the node enters the scene tree for the first time
func _ready():
	pass

func _on_Pellet_body_entered(body: Node) -> void:
	emit_signal( "pellet_collected", COLLECTION_SCORE )
	queue_free()
