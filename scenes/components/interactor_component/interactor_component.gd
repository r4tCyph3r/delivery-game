extends RayCast3D

# Initialises prompt label as its a child of the controller
@onready var interact_prompt_label : Label = $InteractPrompt
@onready var is_grabbing: bool = false
@onready var hand = $Hand
var grabbed_object
var pull_power = 4

func _process(_delta):
	# Uses process frames to see what player raycast is colliding with
	var object = get_collider()
	interact_prompt_label.text = ""
	
	# Code to drop any items held if the key is pressed when not looking at an object
	if object == null:
		if Input.is_action_just_pressed("interact"):
			grabbed_object = null
		return
	
	if object.find_child('InteractionComponent'):
		
		var interaction_component = object.find_child('InteractionComponent')
		
		if interaction_component.can_interact == false:
			return
		
		# handles input when player presses the interact key if the above conditions are met
		interact_prompt_label.text = "Press [E] to " + interaction_component.interact_prompt
			
		if Input.is_action_just_pressed("interact"):
			if object is DeliverableItem:
				toggle_grabbed_object(object)
			interaction_component._interact()

# Used for checking if an object is already grabbed
func toggle_grabbed_object(object):
		if grabbed_object == null:
			grabbed_object = object
			print('grabbed: ', object)
		elif grabbed_object:
			grabbed_object = null
		else:
			print('[Error] Grab Object Failed')

func _physics_process(_delta: float) -> void:
	if grabbed_object != null:
		var a = grabbed_object.global_transform.origin
		var b = hand.global_transform.origin
		grabbed_object.set_linear_velocity((b-a)*pull_power)
