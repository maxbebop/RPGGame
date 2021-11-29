extends KinematicBody2D
class_name Player

var SPEED = 6000
var velocity = Vector2.ZERO
onready var animatrio_tree = $AnimationTree
onready var animation_state = animatrio_tree.get("parameters/playback")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
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
		
	velocity =+ move_and_slide(velocity *delta)


func _on_AreaChangeMask_body_entered(body):
	pass # Replace with function body.
