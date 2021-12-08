extends KinematicBody2D
class_name Player

var SPEED = 6000
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
onready var animatrio_tree = $AnimationTree
onready var animation_state = animatrio_tree.get("parameters/playback")


#func _process(delta):
#	if Input.is_action_pressed("inv_item_1") || Input.is_action_pressed("inv_item_2")|| Input.is_action_pressed("inv_item_3"):
#		Root.player = self


func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left") 
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector =input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animatrio_tree.set("parameters/Idle/blend_position", input_vector)
		animatrio_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = input_vector * SPEED
	else:
		animation_state.travel("Idle")
		velocity  = Vector2.ZERO
		Root.player = self
		
	velocity =+ move_and_slide(velocity *delta)


func _on_AreaChangeMask_body_entered(body):
	pass # Replace with function body.
