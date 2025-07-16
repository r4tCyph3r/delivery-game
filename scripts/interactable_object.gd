## Overarching class for all interactable objects
# currently used by postbox, package and door

class_name interactable_object
extends Node3D

@export var interact_prompt : String
@export var can_interact : bool

func _interact():
	print("Overide kek")
