extends interactable_object

signal money_deposited

func interact():
	emit_signal("money_deposited")
