extends Node3D
class_name PackageSpawnpoint

@export var is_active : bool
@export var spawn_name : String

func get_location():
	var location: Vector3 = self.global_position
	return location
	
