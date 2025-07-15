extends Node3D

@onready var entity_interact_area = $interaction_area

func _ready():
	entity_interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	push_error("Success")
