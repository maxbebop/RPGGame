extends CanvasLayer

var max_level_index = 0
var level_index = 0
var file_path = ""
var file:File = File.new()
var SCENE_EXT = ".tscn"
var LEVEL_SCENE_NAME = "Level_"
onready var inventory_container = $InventoryContainer

var inventory_list = []

func add_gem(gem):
	inventory_list.push_back(gem)
	print(inventory_list)

func _ready():
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
