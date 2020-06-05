extends Area2D


signal pellet_collected( score )

const COLLECTION_SCORE = 10
onready var Walls = get_parent().get_parent()


# Called when the node enters the scene tree for the first time
func _ready():
	pass

func _on_Pellet_body_entered(_body: Node) -> void:
	emit_signal( "pellet_collected", COLLECTION_SCORE )
	Walls.add_pellet_count()
	queue_free()

