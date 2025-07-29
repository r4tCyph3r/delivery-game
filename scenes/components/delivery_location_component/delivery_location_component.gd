### Class is used to define delivery locations
extends Node3D
class_name DeliveryLocationComponent

signal delivery_attempted
signal name_updated

@export var dest_name : String
@onready var InteractComp : InteractionComponent = $InteractionComponent

func _ready() -> void:
	InteractComp.connect('interaction', _on_interact)

func _on_interact():
	emit_signal('delivery_attempted', self.dest_name)
