extends StaticBody2D


onready var activate_coll = $AreaLetters
onready var letters = $Letters
onready var audio = $AudioPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	letters.visible = false


func _on_AreaLetters_body_entered(body):
	if body is Player:
		print("body_entered: " + body.name)
		letters.modulate.a = 1.3
		letters.visible = true
		audio.play()


func _on_AreaLetters_body_exited(body):
	if body is Player:
		print("body_exited: " + body.name)
		letters.visible = false
		audio.stop()
