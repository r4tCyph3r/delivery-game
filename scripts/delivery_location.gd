extends Node3D
class_name DeliveryLocation

# Location number assigned to check delivery location
@export var location_number = 0
@export var is_active : bool = false

# Function used to propagate the delivery address to all of the children of the address
# This is in the event mailboxes, door and other delivery functionality exists
func assign_address(addr):
	location_number = addr
	for loc in get_children():
		# Used to assign correct variable to the doors
		if loc is interactable_object:
			loc.house_address = location_number
		# Used to assign text to the house for ID
		if loc is Label3D:
			loc.text = str(location_number)
	return
