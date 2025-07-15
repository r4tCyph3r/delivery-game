extends Area3D
class_name interaction_area

# Sets the initial text of the interact to always be the same
const base_text = "[E] to "

# external var for interaction type ("press E to <var>")
@export var action_name: String = "interact"

# Init entity label
@onready var label = $interact_label/SubViewport/Label

# callable function for when the object is interacted with
var interact: Callable = func():
	pass

func _on_body_entered(body: Node3D):
	InteractionManager.register_area(self)

func _on_body_exited(body: Node3D):
	InteractionManager.unregister_area(self)

# func on_player_looking():
#	InteractionManager.register_area(self)
# func on_player_not_looking():
#	InteractionManager.register_area(self)
