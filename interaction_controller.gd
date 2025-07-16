extends RayCast3D

@onready var interact_prompt_label : Label = get_node("interaction_prompt")

func _process(_delta):
	var object = get_collider()
	interact_prompt_label.text = ""
	
	
	if object and object is interactable_object:
		if object.can_interact == false:
			return
		
		interact_prompt_label.text = "Press [E] to " + object.interact_prompt
		
		if Input.is_action_just_pressed("interact"):
			object.interact()
