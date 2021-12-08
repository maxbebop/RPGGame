extends Node2D

signal pressed
export var display_text = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = display_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("pressed")
