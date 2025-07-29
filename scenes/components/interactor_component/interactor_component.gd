extends RayCast3D

# Initialises prompt label as its a child of the controller
@onready var interact_prompt_label : Label = $InteractPrompt

func _process(_delta):
	# Uses process frames to see what player raycast is colliding with
	var object = get_collider()
	interact_prompt_label.text = ""
	
	# if an object is returned and has an interactioncomponent node attached it will display interaction text
	if object and object.find_child("InteractionComponent"):
		var interactable = object.find_child("InteractionComponent")
		var deliverable: bool = false
		
		if interactable.can_interact == false:
			return
		
		if object.find_child("DeliverableComponent"):
			deliverable = true
		
		# handles input when player presses the interact key if the above conditions are met.
		interact_prompt_label.text = "Press [E] to " + interactable.interact_prompt
		
		if Input.is_action_just_pressed("interact"):
			interactable._interact()
			
