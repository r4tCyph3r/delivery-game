class_name GameManager
extends Node3D

# preload package so that it can be easily instantiated
var _package = preload("res://Vamp-Surv-Clone/scenes/package.tscn")

# Signals
signal set_package_dest # sets destination for packages in new_package() function

# prepare timer, package count and money variables to be handled by the manager
@onready var package_timer : Timer = $PackageTimer
@onready var package_count : int = 0
@onready var money : int = 0
@onready var cashout : int = 0
@onready var delivery_interactable : Array = get_tree().get_nodes_in_group("delivery_interact")
@onready var delivery_location: Array = get_tree().get_nodes_in_group("delivery_location")
var available_location: Array = []

### Code that has been removed for potential later use
## Using multiple spawnpoints
#@onready var package_spawnpoints: Array = get_tree().get_nodes_in_group("package_spawnpoints")
#var available_spawnpoints: Array = []
#var active_spawnpoint: Vector3
## below is part of the same thing, was in ready func before removing
	#for spawnpoint in package_spawnpoints:
		#available_spawnpoints.append(spawnpoint)
		#if spawnpoint.is_active:
			#active_spawnpoint = spawnpoint.location

## Onready function for the GM
# when it was present the functionality worked a bit better
# currently trying to figure out how to get this working
func _ready() -> void:
	# Loop used to determine the location_number of all addresses spawned and appends to the array current_addresses
	# sets the loc_num to address and then increments the value by 1
	# effectively giving all the houses individual house numbers/values
	var address = 1
	for member in delivery_location:
		if member.location_number == 0:
			member.location_number = address
			available_location.append(address)
			address += 1

	# Loop used to attach the signal to each of the delivery points instantiated
	for interactable in delivery_interactable:
		interactable.delivery_attempted.connect(_on_delivery_attempted)
	
	new_package()

# method creates a variable for package and instances it
func new_package():
	var package = _package.instantiate() # instances new package
	add_child(package) # adds package to the scene tree
	package.global_position = get_active_spawnpoint() # global position sets the spawnpoint to the parcel room
	package.collected.connect(_on_package_collected) # connects interactions signal
	package.destination = get_delivery_location() # determines where the package needs to be delivered
	emit_signal("set_package_dest", package.destination)

# Checks for active package_spawnpoints in the group
# Calls for a location in the event it does not exist
func get_active_spawnpoint():
	for spawn in get_tree().get_nodes_in_group("package_spawnpoints"):
		if spawn.is_active == true:
			return spawn.get_location()
			

# function to determine when the package has been picked up
# adds a count to the package count
func _on_package_collected():
	package_count += 1
	package_timer.start()
	print(package_count)

# Want to get a specific delivery location for a package
func get_delivery_location():
	var selected_location = available_location.pick_random()
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
