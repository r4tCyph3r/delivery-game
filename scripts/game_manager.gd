class_name GameManager
extends Node3D

# preload package so that it can be easily instantiated
# set pre-determined spawnpoint for the package so it respawns in the same place.
var spawn_package = preload("res://Vamp-Surv-Clone/scenes/package.tscn")
var package_spawnpoint : Vector3 = Vector3(92.015, 5.081, 94.058)

# prepare timer, package count and money variables to be handled by the manager
@onready var package_timer : Timer = $PackageTimer
@onready var package_count : int = 0
@onready var money : int = 0
@onready var cashout : int = 0
@onready var houses : Array = get_tree().get_nodes_in_group("delivery_location")

var address = 0

# spawn the initial package as its not present in the main scene tree
# when it was present the functionality worked a bit better
# currently trying to figure out how to get this working
func _ready() -> void:
	print(houses)
	for member in houses:
		member.address = address
		member.delivery_attempted.connect(_on_door_delivery_attempted)
		address += 1
		print(member.address)

# command creates a variable for package and instances it
# add child adds the scene to the scene tree
# global position sets the spawnpoint to the parcel room
func new_package():
	var package = spawn_package.instantiate()
	get_parent().add_child(package)
	package.global_position = package_spawnpoint
	package.collected.connect(_on_package_collected)

# function to determine when the package has been picked up
# adds a count to the package count
func _on_package_collected():
	package_count += 1
	package_timer.start()
	print(package_count)

# wanna get a random delivery location
func get_delivery_location():
	#var location = member.address.pick_random()
	pass

# on timer end spawns new package
func _on_package_timer_timeout() -> void:
	new_package()

# Checks to see if there are any packages on the counter
# If yes generates random int between 0-30 on var "cashinc"
# adds cashinc to cashout which is used to calculate next time get_money() is called
# plan to add get_money() to a button/atm/area but not yet implemented
# removes 1 package from inventory then prints both values
func _on_door_delivery_attempted() -> void:
	if package_count > 0:
		var cashinc : int = randi() % 30
		cashout += cashinc
		package_count -= 1
		print("delivery success you made £" + str(cashinc))
		print("current cashout would be £" + str(cashout))
	return
