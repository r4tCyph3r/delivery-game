class_name GameManager
extends Node3D

var spawn_package = preload("res://Vamp-Surv-Clone/scenes/package.tscn")
var package_spawnpoint : Vector3 = Vector3(92.015, 5.081, 94.058)

@onready var package_timer : Timer = $PackageTimer
@onready var package_count : int = 0
@onready var money : int = 0

func new_package():
	var obj = spawn_package.instantiate()
	add_child(obj)
	obj.global_position = package_spawnpoint
	print(obj.name)

func _on_package_collected() -> void:
	package_count += 1
	package_timer.start()
	print(package_count)

func _on_package_timer_timeout() -> void:
	new_package()
