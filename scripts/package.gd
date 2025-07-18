extends interactable_object

var destination

# sends signal when the package is collected
signal collected

func _ready():
	GameManager.set_package_dest.connect("_on_set_package_dest", destination)

# determines actions when the package is interacted with
func interact():
	emit_signal("collected")
	print("package collected")
	self.queue_free()

func _on_set_package_dest(destination):
	pass
