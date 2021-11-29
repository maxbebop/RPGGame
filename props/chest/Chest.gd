extends StaticBody2D


enum STATE {OPENED, CLOSED}
var ANIM_MAP = {STATE.CLOSED: "closed", STATE.OPENED:"opened"}
export (STATE) var current_state = STATE.CLOSED
var is_player_entered = false
export (Gem.GEM_LIST) var gem_type

onready var cover_anim_sprite = $CoverAnimSprite
onready var shadow_anim_sprite = $ShadowAnimSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	init_anim_sprite()


func _process(delta):
	if can_be_opened() && Input.is_action_pressed("use"):
		current_state = STATE.OPENED
		Root.add_gem(gem_type)
		init_anim_sprite()
		

func init_anim_sprite():
	cover_anim_sprite.play(ANIM_MAP[current_state])
	shadow_anim_sprite.play(ANIM_MAP[current_state])

func can_be_opened():
	return is_player_entered && current_state == STATE.CLOSED

func _on_Area2D_body_entered(body):
	if body is Player:
		print(name + " Player entered")
		is_player_entered = true


func _on_Area2D_body_exited(body):
	if body is Player:
		print(name + " Player exited")
		is_player_entered = false
