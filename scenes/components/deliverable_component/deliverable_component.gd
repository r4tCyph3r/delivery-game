### Class is used to define delivery locations
## Sets destination for the object to be delivered, handles delivery related activity.
extends Node3D
class_name DeliverableComponent


signal new_quest


@onready var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
@onready var destination: String
var can_deliver: bool


func _ready() -> void:
	package_init()


func package_init():
	# Select delivery location
	var dest = delivery_locations.pick_random()
	
	# Might not need the below, wait and see
	# Currently used for delivery functionality
	destination = dest.location_name
	
	# Register this package as expected at the location
	dest.register_delivery(self)
	
	return destination
