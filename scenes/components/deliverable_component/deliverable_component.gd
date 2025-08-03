### Class is used to define delivery locations
extends Node3D
class_name DeliverableComponent

signal store_package

@onready var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
@onready var destination: String
var can_deliver: bool

func _ready() -> void:
	set_destination()

func set_destination():
	var dest = delivery_locations.pick_random()
	destination = dest.location_name
	print(destination)
	return destination

func on_delivery_success(location):
	print(location)
