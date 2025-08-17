### Class is used to define delivery locations
extends Node3D
class_name DeliveryLocationComponent


signal update_wallet
signal name_updated


@onready var InteractComp : InteractionComponent = $InteractionComponent
@onready var delivery_area: Area3D = $DeliveryArea
@onready var area_shape: CollisionShape3D = $DeliveryArea/DeliveryAreaShape
@onready var house_address_label: Label3D = $HouseAddressLabel


var location_name : String
var delivery_items: Array = []
var awaiting_delivery: Array = []
var delivered_packages: Array[DeliveredPackageData] = []


func _ready() -> void:
	InteractComp.connect('interaction', _on_interact)
	delivery_area.connect('body_entered', _on_delivery_body_entered)
	delivery_area.connect('body_exited', _on_delivery_body_exited)
	house_address_label.text = location_name

	## currently connected to debug button, should be connected to bed/cashout button
	for object in get_tree().get_nodes_in_group("RequestLocations"):
		object.connect('day_ended', _on_day_end)


func _on_interact():
	receive_delivery(delivery_items)


func register_delivery(package):
	print(package)

## Registers deliverables in the delivery area to the array delivery_items
func _on_delivery_body_entered(object: Node3D):
	# assigns deliverablecomponent to variable
	var deliverable = object.find_child('DeliverableComponent')
	
	# check array for existing object
	# skip if exists
	if delivery_items.has(object):
		return
	
	# Checks to see if the item has a deliverable component and if its the correct destination
	if deliverable and deliverable.destination == location_name:
		# adds object if not
		delivery_items.append(object)


## Removes deliverables when they exit the delivery area from the array delivery_items
func _on_delivery_body_exited(object):
	# Check to see if object is in array
	if delivery_items.has(object) == false:
		return
	# remove specific object
	delivery_items.erase(object)


## Delivers any items that are in the array
func receive_delivery(items):
	# Check for parcels that are expected
	if items.size() > 0:
		for item in items:
			var delivery_info = item.destroy_and_store(location_name)
			delivered_packages.append(delivery_info)
	else:
		print('No items to sell')


## Determines how much money has been made at the location and sends back to wallet component of player.
func _on_day_end():
	
	var cashout: float = 0
	
	## Used to calculate cash earned over day
	for item in delivered_packages:
		cashout += item.value
	
	delivered_packages.clear()
	
	emit_signal('update_wallet', cashout)
