extends Area2D



func _on_body_entered(body):
	if body.name == 'Player' and not body.checkpoint:
		body.checkpoint_x = position.x
		body.checkpoint_y = position.y
		body.checkpoint = true
		print('Checkpoint at: ', position.x, position.y)
