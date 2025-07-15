# Requirements
# Player can move wasd
# Player can sprint
# Player collides with structures
# Player collides with objects

extends CharacterBody3D

# Define Constants
const SPRINT_SPEED = 20 # Maximum player speed in sprint state
const BASE_SPEED = 18 # Maximum speed in walking state
const ACCEL = 4.5 # how fast the player accelerates
const DEACCEL = 3.5 # how fast the player decellerates
var MOUSE_SENSITIVITY = 0.05 # Mouse Sens but can be modified hence var

# Defined Variables
var dir = Vector3() # Direction handle

# Defined Variables
@onready var camera: Camera3D = $rotation_helper/camera
@onready var rotation_helper: Node3D = $rotation_helper

# onready check to activate camera and rot_helper
func _ready() -> void:
	check_input_mappings()
	look_rotation.y = rotation.y
	look_rotation.x = rotation_helper.rotation.x

func _unhandled_input(event: InputEvent) -> void:
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

func rotate_look():
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)
	

func _physics_process(delta: float) -> void:
	# Sprint
	# Jump
	# Move
	
	# Modify speed based on sprinting
	if Input.is_action_pressed(input_sprint):
			move_speed = sprint_speed
	else:
		move_speed = base_speed
	
	move_and_slide()

## Checks if some Input Actions haven't been created.
## Disables functionality accordingly.
func check_input_mappings():
	if InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
	if InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
	if InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
	if InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
	if InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
	if InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
	if InputMap.has_action(input_freefly):
		push_error("Freefly disabled. No InputAction found for input_freefly: " + input_freefly)
