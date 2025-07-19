extends Node3D
class_name DeliveryLocation

@export var location_name : String
@export var location_number = 0
@export var is_active : bool = false

func assign_address():
	for loc in get_children():
		loc.house_address = location_number
	return
