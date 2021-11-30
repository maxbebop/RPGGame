extends CanvasLayer

var max_level_index = 0
var level_index = 0
var file_path = ""
var file:File = File.new()
var SCENE_EXT = ".tscn"
var LEVEL_SCENE_NAME = "Level_"
var player
onready var inventory_bar = $InventoryContainer
onready var inventory_screen = $InventoryScreen
onready var inventory = $InventoryScreen/Inventory
#const inventory_factory = preload("res://rootScene/Inventory.tscn")
const gem_factory = preload("res://props/gem/Gem.tscn")

var inventory_list = []

func _process(delta):
	if Input.is_action_pressed("inventory"):
		inventory_screen.visible = true
		

func add_gem(gem_type):
	inventory_list.push_back(gem_type)
	var gem = create_gem(gem_type)
	inventory.add(gem)
	print(inventory_list)
	init_inventory_container()
	
func init_inventory_container():
	delete_children(inventory_bar)
	for gem_type in inventory_list:
		var gem = create_gem(gem_type)
		inventory_bar.add_child(gem)
		gem.position.x = 30*inventory_bar.get_child_count()
		
	
func create_gem(gem_type):
	var gem = gem_factory.instance()
	gem.type = gem_type
	gem.is_visible = true
	gem.is_inventory = true
	gem.init()
	return gem

func _ready():
	#inventory = inventory_factory.instance()
	inventory_screen.visible = false
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


func _on_Close_pressed():
	inventory_screen.visible = false


func _on_Inventory_get_item(item):
	print(get_child_count())
