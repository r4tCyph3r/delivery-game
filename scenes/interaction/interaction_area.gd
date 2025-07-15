extends Area3D
class_name interaction_area

@export var action_name: String = "interact"

var interact: Callable = func():
	pass

func _on_body_entered(body: Node3D):
	interaction_manager.register_area(self)

func _on_body_exited(body: Node3D):
	interaction_manager.unregister_area(self)
