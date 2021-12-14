extends Node2D


export var arch_level = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$ArchLevel2.z_index = arch_level+1
	$ArchTopGrass.z_index = arch_level+1
	$ArchBackendLevel2.z_index = arch_level+1
	print("==")
	print("Arch StaticBody_2: " + str($StaticBody_2.get_collision_layer()))
	print("Arch StaticBody_1: " + str($StaticBody_1.get_collision_layer()))
	$StaticBody_1.set_collision_layer(arch_level+1)
	$StaticBody_1.set_collision_mask(arch_level+1)
	
	$StaticBody_2.set_collision_layer(arch_level+2)
	$StaticBody_2.set_collision_mask(arch_level+2)
	print("Arch StaticBody_2 after update")
	print("Arch StaticBody_2: " + str($StaticBody_2.get_collision_layer()))
	print("Arch StaticBody_1: " + str($StaticBody_1.get_collision_layer()))
	print("==")
	$Label.text = "grass z-index: " + str($ArchTopGrass.z_index)
	$Label2.text = "StaticBody_1 collision_layer: " + str($StaticBody_1.get_collision_layer())
	$Label3.text = "StaticBody_2 collision_layer: " + str($StaticBody_2.get_collision_layer())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
