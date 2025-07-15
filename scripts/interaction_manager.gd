extends Node3D
class_name interaction_manager

# Identifies the player node using groups
# Identifies the label child
@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

# Sets the initial text of the interact to always be the same
const base_text = "[E] to "

# Defines Variables
# an array storing interaction areas that are instanciated
# a boolean to determine if an entity can be interacted with
var active_areas: Array = []
var can_interact: bool = true

## Two functions to determine what areas are close enough that the user can interact with them
# Appends the array "active_areas" with areas that the user can interact with
func register_area(area: interaction_area):
	active_areas.push_back(area)

# Appends the array "active_areas" to remove areas that the user cannot interact with
func unregister_area(area: interaction_area):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

# Process func happens every frame
# Checks to see if there are any areas the player is stood in and if they can interact with them
func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.show()
	else:
		label.hide()

# Checks distance of 2 input areas and returns the shorter distance input
# Used for handling which interactable is displayed
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

# 
func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
