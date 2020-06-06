extends AnimatedSprite

onready var BoardScoreboard = get_parent().get_parent().get_parent().get_node("BoardScoreboard")

signal fruit_collected

func _on_Fruit_body_entered(_body: Node) -> void:
	emit_signal("fruit_collected")
	BoardScoreboard.add_score(1000)
	queue_free()
