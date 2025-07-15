extends RayCast3D

@onready var prompt = $debug_prompt



func _physics_process(_delta):
	prompt.text = ""
	
	if is_colliding():
		prompt.text = "Detected Object"
