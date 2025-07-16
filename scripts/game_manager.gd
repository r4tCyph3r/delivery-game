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

# spawn the initial package as its not present in the main scene tree
# when it was present the functionality worked a bit better
# currently trying to figure out how to get this working
func _ready() -> void:
	#new_package()
	pass

# command creates a variable for package and instances it
# add child adds the scene to the scene tree
# global position sets the spawnpoint to the parcel room
func new_package():
	var package = spawn_package.instantiate()
	get_parent().add_child(package)
	package.global_position = package_spawnpoint
	print(package.get_property_list())

# function to determine when the package has been picked up
# adds a count to the package count
# starts the timer to spawn the new package
# prints current count
# current issue is the signal disconnects once the queue is freed
# a solution might be handling the interaction within the interact manager but not sure if thats better
func _on_package_collected():
	package_count += 1
	package_timer.start()
	print(package_count)

# on timer end spawns new package
func _on_package_timer_timeout() -> void:
	new_package()
