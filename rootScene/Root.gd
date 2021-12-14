extends CanvasLayer

var max_level_index = 0
var level_index = 0
var file_path = ""
var file:File = File.new()
var SCENE_EXT = ".tscn"
var LEVEL_SCENE_NAME = "Level_"
var is_altar_activeted = false
var is_game_available = false
var player

#onready var inventory_bar = $InventoryContainer
onready var inventory = $Inventory
onready var game_menu = $GameMenu
onready var game_over_timer = $GameOverTimer
onready var game_audio = $GameAudioPlayer
#const inventory_factory = preload("res://rootScene/Inventory.tscn")
const gem_factory = preload("res://props/gem/Gem.tscn")

var inventory_list = []
	

func _process(_delta):
	#if Input.is_action_pressed("inventory"):
	#inventory_screen.visible = true
	pass
		
func remove_gem(gem_type):
	var index = inventory_list.find(gem_type)
	if index > -1:
		inventory_list.remove(index)
		#init_inventory_container()
		
func add_gem(gem_type):
	inventory_list.push_back(gem_type)
	var gem = create_gem(gem_type)
	inventory.add(gem)
	print(inventory_list)
	#init_inventory_container()

func show_game_menu():
	game_menu.visible = true
	is_game_available = false
	
func hide_game_menu():
	game_menu.visible = false
	is_game_available = true

func game_over():
	game_over_timer.start()
		
	
func create_gem(gem_type):
	var gem = gem_factory.instance()
	gem.type = gem_type
	gem.is_visible = true
	gem.is_inventory = true
	gem.init()
	return gem

func _ready():
	show_game_menu()
	load_scene()

func load_next_scene():
	level_index +=1
	load_scene()

func load_scene():
	file_path = create_scene_path()
	if file.file_exists(file_path):
		get_tree().change_scene(file_path)
		
func create_scene_path():	
	var scene_name = create_scene_name()

	return  "res://levels/" + scene_name

func create_scene_name():		
	return LEVEL_SCENE_NAME + str(level_index) + SCENE_EXT

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
		
func set_game_audio_volume_db_up(value: float):
	if game_audio.volume_db < -10:
		game_audio.volume_db += value
	
func set_game_audio_volume_db_down(value: float):
	game_audio.volume_db -= value

func _on_Inventory_get_item(item):
	print(str(player.position) + " type: " + str(item.type))
	var gem = create_gem(item.type)
	remove_gem(item.type)
	item.queue_free()
	gem.is_inventory = false
	gem.is_visible = true
	gem.init()
	var level = player.get_parent()
	level.add_child(gem)
	gem.z_index = player.z_index
	gem.position = player.position


func _on_NewGameButton_pressed():
	hide_game_menu()
	load_scene()


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_GameOverTimer_timeout():
	show_game_menu()
