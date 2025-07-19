extends interactable_object

signal delivery_attempted

var house_address

func interact():
	emit_signal("delivery_attempted")
	print("House Address", house_address)
