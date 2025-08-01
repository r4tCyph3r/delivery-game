extends interactable_object

# sends signal when the package is collected
signal collected

func _ready():
	pass

# determines actions when the package is interacted with
func interact():
	emit_signal("collected")
	print("package collected")
	self.queue_free()
