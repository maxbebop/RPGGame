extends Node
class_name Gem

enum GEM_LIST  {RED, BLUE, GREEN}
var ANIM_MAP = {GEM_LIST.RED:"red", GEM_LIST.GREEN:"green", GEM_LIST.BLUE:"blue"}
export (GEM_LIST) var type = GEM_LIST.RED
onready var anim_sprite = $AnimatedSprite
export var is_on_ground = false;

func _process(delta):
	if is_on_ground:
		anim_sprite.play(ANIM_MAP[type])
