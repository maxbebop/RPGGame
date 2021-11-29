extends Node2D

var y_entered = 0
var y_exited = 0

var up_entered = false
var down_enterd = false

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
	if body is Player && down_enterd:
		set_player_layer(body, -1)
	down_enterd = false

func _on_UpAreaChangeMask_body_entered(body):
	if body is Player:
		up_entered = true
		down_enterd = false


func _on_DownArea2D_body_entered(body):
	if body is Player:
		down_enterd = true
		up_entered = false


func _on_DownArea2D_body_exited(body):
	if body is Player && up_entered:
		set_player_layer(body, 1)
	up_entered = false
