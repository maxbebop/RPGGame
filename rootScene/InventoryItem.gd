extends Node2D

signal get_item(item)

var _item
var is_empty = true
export var index = 1
var action_name = "inv_item_"
onready var item_button = $Button
onready var anim_sprite = $ItemAnimatedSprite
onready var index_label = $ItemIndexLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	index_label.text = str(index)

func _process(_delta):
	if Input.is_action_pressed(action_name + str(index)):
		get_item_pressed()

func add_item(item):
	_item = item
	is_empty = false
	#item_button.add_child(_item)
	add_child(_item)
	anim_sprite.play((_item as Gem).get_str_color())
	#(_item as Gem).position.x += 17
	#(_item as Gem).position.y += 17
	
	

func get_item_pressed():
	if !is_empty:
		is_empty = true
		anim_sprite.play("empty")
		emit_signal("get_item", _item)


func _on_TouchScreenButton_pressed():
	get_item_pressed()
