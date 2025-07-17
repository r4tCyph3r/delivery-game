extends interactable_object

var destination

# sends signal when the package is collected
signal collected

# determines actions when the package is interacted with
func interact():
	emit_signal("collected")
	print("package collected")
	self.queue_free()
