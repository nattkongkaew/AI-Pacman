extends AnimatedSprite

signal fruit_collected

func _on_Fruit_body_entered(body: Node) -> void:
	emit_signal("fruit_collected")
	queue_free()
