extends StaticBody2D

onready var tile_map_letter = $TileMapLetters
onready var audio = $AreaLetter/AudioPlayer
onready var gem_area = $GemArea

var player
var is_player_entered = false
var step = 1
var start_distance = 0
var glow_delta = 0.13
var glow_volume_step = 10
var audio_volume_db_step = 0.05
var audio_volume_db_min = -20
var prev_distance = 0
var is_activated = false
var gem
var base_color =Color(0, 1, 1, 1) #Color(0,247,255)
enum GEM_LIST  {RED, BLUE, GREEN}
var ANIM_MAP = {GEM_LIST.RED:Color(255,0,0,255), GEM_LIST.GREEN:Color(0,255,0,255), GEM_LIST.BLUE:Color(0,0,255,255)}

export (GEM_LIST) var type = GEM_LIST.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map_letter.visible = false

func _process(_delta):
	var gem_area_coll_list = gem_area.get_overlapping_areas()
	if is_player_entered:
		for area in gem_area_coll_list:
			if area is Gem:
				is_activated = type == area.type
				break
			is_activated = false
	#$Label.text = "type: " + str(type) + "; is activated: " + str(is_activated)

func _physics_process(_delta):
	if is_player_entered:
		var distance = get_distance()
		var d = (start_distance - distance)/step
		init_glow(d)
		if(prev_distance > distance):
			audio.volume_db += d*audio_volume_db_step

		elif prev_distance < distance:
			audio.volume_db -= d*audio_volume_db_step
		
		prev_distance = distance
	if is_activated:
		init_glow(1)


func init_glow(_value):
	if is_activated:
		tile_map_letter.modulate = ANIM_MAP[type]
		#print("tile_map_letter.modulate: " + str(tile_map_letter.modulate))
	else:
		tile_map_letter.modulate = base_color
		var alpha = abs(_value*glow_delta)
		if alpha  > 1: alpha = 1
		tile_map_letter.modulate.a = alpha
		#print("tile_map_letter.modulate: " + str(tile_map_letter.modulate))
	
func get_step(_start_distance):
	return _start_distance/glow_volume_step

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
		if !is_activated:
			tile_map_letter.visible = false
		audio.stop()




func _on_GemArea_body_entered(body):
	if body is Gem:
		print("Gem entered")


func _on_GemArea_body_exited(body):
	if body is Gem:
		print("Gem exited")
