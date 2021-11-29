extends StaticBody2D


onready var tile_map_letter = $TileMapLetters
onready var audio = $AreaLetter/AudioPlayer

var player
var is_player_entered = false
var step = 1
var start_distance = 0
var glow_delta = 0.13
var glow_volume_step = 10
var audio_volume_db_step = 0.05
var audio_volume_db_min = -20
var prev_distance = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map_letter.visible = false

func _physics_process(delta):
	if is_player_entered:
		var distance = get_distance()
		var d = (start_distance - distance)/step
		tile_map_letter.modulate.a = d*glow_delta
		if(prev_distance > distance):
			audio.volume_db += d*audio_volume_db_step

		elif prev_distance < distance:
			audio.volume_db -= d*audio_volume_db_step
		
		prev_distance = distance
		
		
func get_step(start_distance):
	return start_distance/glow_volume_step

func get_distance():
	var distance = pow(player.global_position.x - self.global_position.x,2) + pow(player.global_position.y - self.global_position.y,2)
	return sqrt(distance) 
	
func _on_AreaLetter_body_entered(body):
	if body is Player:
		player = body
		start_distance = get_distance()
		prev_distance = start_distance
		step = get_step(start_distance)
		is_player_entered = true
		tile_map_letter.visible = true
		tile_map_letter.modulate.a = glow_delta
		audio.volume_db = audio_volume_db_min
		
		audio.play()


func _on_AreaLetter_body_exited(body):
	if body is Player:
		player = null
		is_player_entered = false
		tile_map_letter.visible = false
		audio.stop()


