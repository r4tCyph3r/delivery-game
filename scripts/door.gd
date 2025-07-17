extends interactable_object

signal delivery_attempted

func interact():
	emit_signal("delivery_attempted")
