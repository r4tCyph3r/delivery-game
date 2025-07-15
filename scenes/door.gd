extends Node3D

@onready var entity_interact_area: interaction_area = $interaction_area

func _ready() -> void:
	entity_interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("KEKW")
