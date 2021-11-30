extends GridContainer
class_name Inventory

signal get_item(item)

onready var inventory_item1 = $InventoryItem
onready var inventory_item2 = $InventoryItem2
onready var inventory_item3 = $InventoryItem3

const inventory_item_factory = preload("res://rootScene/InventoryItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add(item):
#	var inv_item = inventory_item_factory.instance()
#	add_child(inv_item)
#	inv_item.add_item(item)
#	inv_item.position.y = 35*inv_item.get_child_count()
#	connect("get_item", self, "_on_InventoryItem_get_item")
	if inventory_item1.is_empty:
		inventory_item1.add_item(item)
	elif inventory_item2.is_empty:
		inventory_item2.add_item(item)
	elif inventory_item3.is_empty:
		inventory_item3.add_item(item)

func _on_InventoryItem_get_item(item):
	emit_signal("get_item", item)
