extends Label3D

func _on_delivery_location_component_name_updated(new_name) -> void:
	self.text = new_name
