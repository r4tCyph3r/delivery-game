extends Node3D
class_name PlayerInputComponent

## Maps player input and checks that they are mapped
# Player Controller Component
@export_group("Input Actions")
@export var input_left : String = "move_left"
@export var input_right : String = "move_right"
@export var input_forward : String = "move_forward"
@export var input_back : String = "move_backward"
@export var input_jump : String = "move_jump"
@export var input_sprint : String = "move_sprint"
@export var input_freefly : String = "move_freefly"
@export var input_interact: String = 'interact'
@export var can_freefly : bool = false
@export var mouse_sens : float = 0.002

@onready var move : MovementComponent = $MovementComponent
@onready var head : HeadComponent = $MovementComponent/HeadComponent

var mouse_captured : bool = false
var look_rotation : Vector2
var input_dir: Vector2
var input_motion

func _ready() -> void:
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x
	check_input_mappings()

func _unhandled_input(event: InputEvent) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()

	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

	# Toggle freefly mode
	if can_freefly and Input.is_action_just_pressed(input_freefly):
		if not move.freeflying:
			move.freeflying = true
			move.motion = input_motion
		else:
			move.freeflying = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('move_jump'):
		move._on_jump()
		
	if Input.is_action_just_pressed('move_freefly'):
		move._on_freefly()
		
	if Input.is_action_pressed('move_sprint'):
		move.move_speed = move.sprint_speed
	else:
		move.move_speed = move.base_speed
	
	input_dir = Input.get_vector(input_left, input_right, input_forward, input_back)
	move.input_dir = input_dir

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

## Used to debug action presses
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed('move_forward'):
		#print("forward")
	#if Input.is_action_just_pressed('move_backward'):
		#print('backward')
	#if Input.is_action_just_pressed('move_left'):
		#print('left')
	#if Input.is_action_just_pressed('move_right'):
		#print('right')
	#if Input.is_action_just_pressed('move_jump'):
		#print('jump')
	#if Input.is_action_just_pressed('move_sprint'):
		#print('sprint')
	#if Input.is_action_just_pressed('move_freefly'):
		#print('freefly')
	#if Input.is_action_just_pressed('interact'):
		#print('interact')

func rotate_look(rot_input : Vector2):
	# Handle vertical rotation (looking up/down)
	look_rotation.x -= rot_input.y * mouse_sens
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))

	# Handle horizontal rotation (looking left/right)
	look_rotation.y -= rot_input.x * mouse_sens

	# Apply rotations
	# Reset and apply horizontal rotation to movement component
	move.transform.basis = Basis()
	move.rotate_y(look_rotation.y)

	# Reset and apply vertical rotation to head only
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)

func check_input_mappings():
	## Checks if some Input Actions haven't been created.
	# Pushes errors if any inputs are not mapped
	if not InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
	if not InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
	if not InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
	if not InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
	if not InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
	if not InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
	if not InputMap.has_action(input_freefly):
		push_error("Freefly disabled. No InputAction found for input_freefly: " + input_freefly)
