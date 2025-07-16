extends RayCast3D

# Initialises prompt label as its a child of the controller
@onready var interact_prompt_label : Label = get_node("interaction_prompt")

# Uses process frames to see what player raycast is colliding with
# if an object is returned and is extending the class interactable_object it will show a prompt
# handles input when player presses the interact key if the above conditions are met.
func _process(_delta):
	var object = get_collider()
	interact_prompt_label.text = ""
	
	
	if object and object is interactable_object:
		if object.can_interact == false:
			return
		
		interact_prompt_label.text = "Press [E] to " + object.interact_prompt
		
		if Input.is_action_just_pressed("interact"):
			object.interact()
