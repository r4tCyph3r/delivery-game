class_name GameManager
extends Node3D

# preload package so that it can be easily instantiated
var spawn_package = preload("res://Vamp-Surv-Clone/scenes/package.tscn")

# prepare timer, package count and money variables to be handled by the manager
@onready var package_timer : Timer = $PackageTimer
@onready var package_count : int = 0
@onready var money : int = 0
@onready var cashout : int = 0
@onready var delivery_interactable : Array = get_tree().get_nodes_in_group("delivery_interact")
@onready var delivery_location: Array = get_tree().get_nodes_in_group("delivery_location")
@onready var package_spawnpoints: Array = get_tree().get_nodes_in_group("package_spawnpoints")
var available_addresses: Array = []
var available_spawnpoints: Array = []
var active_spawnpoint: Vector3
var address = 1

## Onready function for the GM
# when it was present the functionality worked a bit better
# currently trying to figure out how to get this working
func _ready() -> void:
	# Loop used to determine the location_number of all addresses spawned and appends to the array current_addresses
	# sets the loc_num to address and then increments the value by 1
	# effectively giving all the houses individual house numbers/values
	for member in delivery_location:
		if member.location_number == 0:
			member.location_number = address
			available_addresses.append(address)
			address += 1
	print(available_addresses)

	# Loop used to attach the signal to each of the delivery points instantiated
	for interactable in delivery_interactable:
		interactable.delivery_attempted.connect(_on_delivery_attempted)
	
	for spawnpoint in package_spawnpoints:
		available_spawnpoints.append(spawnpoint)
		if spawnpoint.is_active:
			active_spawnpoint = spawnpoint.location
	
	new_package()

# command creates a variable for package and instances it
# add child adds the scene to the scene tree
# global position sets the spawnpoint to the parcel room
func new_package():
	var package = spawn_package.instantiate()
	print(str(active_spawnpoint) + str(package.global_position))
	add_child(package)
	package.global_position = active_spawnpoint
	package.collected.connect(_on_package_collected)
	package.destination = get_delivery_location()
	print(package.destination)

# function to determine when the package has been picked up
# adds a count to the package count
func _on_package_collected():
	package_count += 1
	package_timer.start()
	print(package_count)

# Want to get a specific delivery location for a package
func get_delivery_location():
	var selected_location = available_addresses.pick_random()
	return selected_location

# on timer end spawns new package
func _on_package_timer_timeout() -> void:
	new_package()

# Checks to see if there are any packages on the counter
# If yes generates random int between 0-30 on var "cashinc"
# adds cashinc to cashout which is used to calculate next time get_money() is called
# plan to add get_money() to a button/atm/area but not yet implemented
# removes 1 package from inventory then prints both values
func _on_delivery_attempted() -> void:
	if package_count > 0:
		var cashinc : int = randi() % 30
		cashout += cashinc
		package_count -= 1
		print("delivery success you made £" + str(cashinc))
		print("current cashout would be £" + str(cashout))
		return
