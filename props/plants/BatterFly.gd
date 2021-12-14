extends Node2D


export var speed = 10
onready var path_folow = get_parent()

func _physics_process(delta):
	path_folow.set_offset(path_folow.get_offset() + speed*delta)
