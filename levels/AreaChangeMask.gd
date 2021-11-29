extends Area2D

var y_entered = 0
var y_exited = 0


func _on_AreaChangeMask_body_exited(body):
	var coll_layer = body.get_collision_layer()
	var coll_mask = body.get_collision_mask()
	print("z-index start: " + str(body.z_index))
	if body is Player:
		y_exited = body.position.y
	if y_entered > y_exited:
		body.z_index += 1
		body.set_collision_layer(coll_layer+1)
		body.set_collision_mask(coll_mask+1)
	elif  y_entered < y_exited:
		body.z_index -= 1
		body.set_collision_layer(coll_layer - 1)
		body.set_collision_mask(coll_mask - 1)
	y_entered = 0
	y_exited = 0
	print("z-index end: " + str(body.z_index))


func _on_AreaChangeMask_body_entered(body):
	if body is Player:
		y_entered = body.position.y
