### Class is used to define delivery locations
extends Node3D
class_name DeliverableComponent

signal store_package

enum ITEM_INTERACT_TYPE {pickup, grab, drag}

@export var type : ITEM_INTERACT_TYPE
@onready var interact_comp : InteractionComponent = $InteractionComponent
@onready var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
@onready var destination : Dictionary = {'name':'','node':''}

func _ready() -> void:
	interact_comp.connect('interaction', _on_interact)
	set_destination()

func _on_interact():
	match type:
		ITEM_INTERACT_TYPE.pickup:
			destroy_and_store()
		ITEM_INTERACT_TYPE.grab:
			emit_signal('grab_object')
		ITEM_INTERACT_TYPE.drag:
			emit_signal('drag_object')

func set_destination():
	var dest = delivery_locations.pick_random()
	destination.node = dest
	destination.name = dest.dest_name
	return destination

func destroy_and_store():
	var package_data = PackageData.create('Parcel', destination.name, 100)
	emit_signal('store_package', package_data)
	get_parent().queue_free()
