extends interactable_object

signal collected

func interact():
	emit_signal("collected")
	print("package collected")
	queue_free()
