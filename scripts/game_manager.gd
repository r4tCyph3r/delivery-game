class_name GameManager
extends Node3D

# preload package so that it can be easily instantiated
var _package = preload("res://Vamp-Surv-Clone/scenes/package.tscn")

## Declare onready variables
# Package timer used to spawn the next package
@onready var package_timer : Timer = $PackageTimer
# Package count used to keep track of current packages in players inventory
@onready var package_count : int = 0
# Money is what each delivery gives individually
@onready var money : int = 0
# wallet is what the player is currently holding
@onready var wallet : int = 0
# bank is what the player has deposited
@onready var bank : int = 0

## Declare onready arrays for interables present and locations present
@onready var delivery_interactable_nodes : Array = get_tree().get_nodes_in_group("delivery_interact")
@onready var delivery_nodes: Array = get_tree().get_nodes_in_group("delivery_location")
@onready var bank_interactable_nodes: Array = get_tree().get_nodes_in_group("bank_interact")

## Declare lists containing available locations
var available_location: Array = []
## Declares list containing current expected deliveries
var delivery_list: Array = []

func _ready() -> void:
	# Loop used to determine the location_number of all addresses spawned and appends to the array current_addresses
	# sets the loc_num to address and then increments the value by 1
	# effectively giving all the houses individual house numbers/values
	var address = 1
	for member in delivery_nodes:
		if member.location_number == 0:
			available_location.append(address)
			member.assign_address(address)
			address += 1
	connect_signals()
	new_package()

# Connects all signals for instanced interactable nodes
func connect_signals():
	for interactable in delivery_interactable_nodes:
		interactable.delivery_attempted.connect(_on_delivery_attempted)
	
	for interactable in bank_interactable_nodes:
		interactable.money_deposited.connect(_on_money_deposited) 

# When bank is interacted with
func _on_money_deposited():
	bank += wallet
	wallet = 0
	print("Bank Balance: £", bank)
	
# Method creates a variable for package and instances it
func new_package():
	var package = _package.instantiate() # instances new package
	add_child(package) # adds package to the scene tree
	package.global_position = get_active_spawnpoint() # global position sets the spawnpoint to the parcel room
	package.collected.connect(_on_package_collected) # connects interactions signal

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
	delivery_list.append(set_delivery_location())
	print("Current Deliveries: ", delivery_list)
	package_timer.start()

# Want to get a specific delivery location for a package
func set_delivery_location():
	var selected_location = available_location.pick_random()
	return selected_location

# Validate a delivery address matches the current order
func check_delivery(address):
	for order in delivery_list:
		if delivery_list.has(address):
			var to_remove = delivery_list.find(address)
			delivery_list.remove_at(to_remove)
			return true

# on timer end spawns new package
func _on_package_timer_timeout() -> void:
	new_package()

# Checks to see if there are any packages on the counter
# If yes generates random int between 0-30 on var "cashinc"
# adds cashinc to cashout which is used to calculate next time get_money() is called
# plan to add get_money() to a button/atm/area but not yet implemented
# removes 1 package from inventory then prints both values
func _on_delivery_attempted(address) -> void:
	if package_count < 1:
		print("got no packages fella")
		return
	
	if check_delivery(address):
		var cashinc : int = randi() % 30
		wallet += cashinc
		package_count -= 1
		print("delivery success you made £" + str(cashinc))
	else:
		print("Wrong Address")
	return
