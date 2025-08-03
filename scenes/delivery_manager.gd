extends Node3D
class_name DeliveryManager
##!!! IMPORTANT !!!##
#Most delivery related interactions are now handled in the objects or locations themselves
#This was used temporarily whilst figuring out how it worked


#### Finds all current delivery locations available
@onready var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
#@onready var request_locations: Array = get_tree().get_nodes_in_group('RequestLocations')

#var outstanding_deliveries: Array[PackageData] = []

### Assign delivery locations names from a list
func _ready() -> void:
	set_location_names()
	#new_package('parcel', global_position)
	#connect_signals()

func set_location_names():
	## Function for selecting location names from array of variables
	### Arrays containing words to be used as delivery locations
	var available_prefixes: Array = ['Test', 'Shire', 'Lampelswine', 'Stratton', 'Alzamala', 'Swindlestone', 'Antarctic', 'Disgusting']
	var available_suffixes: Array = ['House', 'Bog', 'Alley', 'Tree', 'Grove', 'Forest', 'Block', 'Gaggle', 'Center', 'Shithole']
	for loc in delivery_locations:
		available_prefixes.shuffle()
		available_suffixes.shuffle()
		var dest_pre = available_prefixes.pop_at(randi() % available_prefixes.size())
		var dest_suf = available_suffixes.pop_at(randi() % available_suffixes.size())
		loc.location_name = str(dest_pre,' ', dest_suf)
		loc.emit_signal('name_updated', loc.location_name)

#func connect_signals():
	#for loc in request_locations:
		#loc.connect('request_package', new_package)

#func new_package(requested_package, package_location):
	## select package type
	#var parcel
	#### Temporary parcel delcaration
	#if requested_package == 'parcel':
		#parcel = preload("res://Vamp-Surv-Clone/scenes/packages/DeliverableItem.tscn")
	#
	### spawn package
	#var package = parcel.instantiate() # instances new package
	#add_child(package) # adds package to the scene tree
	#if package.find_child('DeliverableComponent'):
		#package.find_child('DeliverableComponent').connect('store_package', _on_pickup)
		#package.global_position = package_location

#func _on_pickup(package_data):
	#outstanding_deliveries.append(package_data)
	#print('Current deliveries: ', package_data.package , ' -> ', package_data.destination, ' -> ', package_data.value)
#
#func _on_delivery(current_location, ground_deliveries):
	#var loc = current_location
	#check_player_inventory(loc)
	#check_location_ground(loc, ground_deliveries)

#func check_player_inventory(current_location):
	#for index in outstanding_deliveries.size():
		#if outstanding_deliveries[index].destination == current_location:
			##emit_signal('money_changed', outstanding_deliveries[index].value)
			#print(outstanding_deliveries[index].package, ' has been delivered successfully! +£' , outstanding_deliveries[index].value)
			#outstanding_deliveries.remove_at(index)
			#return
		#else:
			#print('[DeliveryManager] Wrong Address')

#func check_location_ground(location, ground_deliveries):
	#pass
