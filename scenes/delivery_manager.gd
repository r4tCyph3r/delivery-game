extends Node3D
class_name DeliveryManager
##!!! IMPORTANT !!!##
#Most delivery related interactions are now handled in the objects or locations themselves
#This was used temporarily whilst figuring out how it worked
#
#To remove the last section I would just need to have a list of locations available at the 
#start that when a location selects a prefix / suffix it removes the available names from the array.
###


#### Finds all current delivery locations available
@onready var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
#@onready var request_locations: Array = get_tree().get_nodes_in_group('RequestLocations')
#var outstanding_deliveries: Array[PackageData] = []


### Assign delivery locations names from a list
func _ready() -> void:
	set_location_names()


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
#		loc.update_nametag()
