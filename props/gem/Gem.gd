extends Node
class_name Gem

enum GEM_LIST  {RED, BLUE, GREEN}
var ANIM_MAP = {GEM_LIST.RED:"red", GEM_LIST.GREEN:"green", GEM_LIST.BLUE:"blue"}
export (GEM_LIST) var type = GEM_LIST.RED
onready var anim_sprite = $AnimatedSprite
onready var collsion = $CollisionShape2D
export var is_visible = false;
export var is_inventory = false;


func init():
	if is_visible:
		$AnimatedSprite.play(ANIM_MAP[type])
	$CollisionShape2D.disabled = is_inventory
