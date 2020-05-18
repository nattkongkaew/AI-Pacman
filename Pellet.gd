extends Area2D

# Create signal to send out when pellet is collected
signal pellet_collected( score )

# Set value score of each pellet
const COLLECTION_SCORE = 10

# Function to send message to stdout when pellet is collected by Pacman
# When Pacman enter the collision area of pellet, pellet disappear, updating the score
func _on_Pellet_body_entered(body: Node) -> void:
	emit_signal( "pellet_collected", COLLECTION_SCORE )
	queue_free()
