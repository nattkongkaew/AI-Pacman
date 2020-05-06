extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_Pellet_area_entered(_area):
	queue_free()
