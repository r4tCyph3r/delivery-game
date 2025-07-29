extends Node3D
class_name InteractionComponent

signal interaction

@export var interact_prompt : String
@export var can_interact : bool

func _interact():
	emit_signal('interaction')
