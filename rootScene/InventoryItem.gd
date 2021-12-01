extends Node2D

signal get_item(item)

var _item
var is_empty = true
onready var item_button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func add_item(item):
	_item = item
	is_empty = false
	item_button.add_child(_item)
	(_item as Gem).position.x += 17
	(_item as Gem).position.y += 17
	
	

func _on_Button_pressed():
	if !is_empty:
		is_empty = true
		emit_signal("get_item", _item)
