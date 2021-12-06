extends StaticBody2D


onready var activate_coll = $AreaLetters
onready var letters = $Letters
onready var audio = $AudioPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	letters.visible = false

func is_activated():
	var is_activated = false
	var obelisk_list = get_parent().get_tree().get_nodes_in_group("obelisk")
	for obl in obelisk_list:
		if obl.is_activated: 
			is_activated = true
		else:
			is_activated = false 
	return is_activated

func _on_AreaLetters_body_entered(body):
	if body is Player && is_activated():
		print("body_entered: " + body.name)
		#letters.modulate.a = 1.3
		letters.modulate = Color(0,247,255, 0.1) 
		letters.visible = true
		audio.play()


func _on_AreaLetters_body_exited(body):
	if body is Player && is_activated():
		print("body_exited: " + body.name)
		letters.visible = false
		audio.stop()
