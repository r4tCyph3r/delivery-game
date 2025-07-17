extends Node3D
class_name PackageSpawnpoint

@export var is_active : bool
@export var spawn_name : String

@onready var marker = $Marker3D
@onready var location: Vector3
