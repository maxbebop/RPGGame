extends Node
class_name Gem

enum GEM_LIST  {RED, BLUE, GREEN}
var ANIM_MAP = {GEM_LIST.RED:"red", GEM_LIST.GREEN:"green", GEM_LIST.BLUE:"blue"}
export (GEM_LIST) var type = GEM_LIST.RED
onready var anim_sprite = $AnimatedSprite
onready var collsion = $CollisionShape2D
export var is_visible = false;
export var is_inventory = false;
var is_player_entered = false


func _process(_delta):
	if is_player_entered && Input.is_action_pressed("use"):
		Root.add_gem(type)
		queue_free()
	#else:
	#	$CollisionShape2D.visible = !is_inventory

func init():
	if is_visible:
		$AnimatedSprite.play(ANIM_MAP[type])
	$CollisionShape2D.visible = !is_inventory
	


func _on_Gem_body_entered(body):
	if body is Player:
		is_player_entered = true


func _on_Gem_body_exited(body):
	if body is Player:
		is_player_entered = false
