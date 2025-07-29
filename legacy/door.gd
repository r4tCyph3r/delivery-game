extends interactable_object

signal delivery_attempted

@onready var house_address

func interact():
	emit_signal("delivery_attempted", house_address)
