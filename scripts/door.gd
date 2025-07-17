extends interactable_object

var address : int

signal delivery_attempted

func interact():
	emit_signal("delivery_attempted")
