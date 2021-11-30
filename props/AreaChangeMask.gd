extends Node2D

var entered_direction = Vector2.ZERO

func set_player_layer(body, dirction):
	var coll_layer = body.get_collision_layer()
	var coll_mask = body.get_collision_mask()
	print("z-index start: " + str(body.z_index))
	if dirction < 0:
		body.z_index += 1
		body.set_collision_layer(coll_layer+1)
		body.set_collision_mask(coll_mask+1)
	elif  dirction > 0:
		body.z_index -= 1
		body.set_collision_layer(coll_layer - 1)
		body.set_collision_mask(coll_mask - 1)
	print("z-index end: " + str(body.z_index))

func _on_UpAreaChangeMask_body_exited(body):
	if body is Player:
		var player = body as Player
		print("exited: input_vector - " + str(player.input_vector) + " entered_direction: " + str(entered_direction))
		if (entered_direction.y < 0 && player.input_vector.y < 0) || (entered_direction.y > 0 && player.input_vector.y > 0):
			set_player_layer(body, player.input_vector.y)
		entered_direction = Vector2.ZERO

func _on_UpAreaChangeMask_body_entered(body):
	if body is Player:
		var player = body as Player
		print("entered: " + str(player.input_vector))
		entered_direction = player.input_vector


