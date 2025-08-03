### Class is used to define delivery locations
extends Node3D
class_name DeliveryLocationComponent

signal update_wallet
signal name_updated

@onready var InteractComp : InteractionComponent = $InteractionComponent
@onready var delivery_area: Area3D = $DeliveryArea
@onready var area_shape: CollisionShape3D = $DeliveryArea/DeliveryAreaShape
var location_name : String
var delivery_items: Array = []

func _ready() -> void:
	InteractComp.connect('interaction', _on_interact)
	delivery_area.connect('body_entered', _on_delivery_body_entered)
	delivery_area.connect('body_exited', _on_delivery_body_exited)

func _on_interact():
	receive_delivery(delivery_items)

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

	print(delivery_items)
	
func _on_delivery_body_exited(object):
	# Check to see if object is in array
	if delivery_items.has(object) == false:
		return
	# remove specific object
	delivery_items.erase(object)
	
	print(delivery_items)

func receive_delivery(items):
	if items.size() > 0:
		for item in items:
			emit_signal('update_wallet', item.value)
			item.queue_free()
	else:
		print('No items to sell')
