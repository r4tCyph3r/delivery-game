extends CharacterBody3D
class_name MovementComponent

# Movement Component
@export var can_move : bool = true
@export var has_gravity : bool = true
@export var can_jump : bool = true
@export var can_sprint : bool = false

@export_group("Speeds")
@export var base_speed : float = 7.0
@export var jump_velocity : float = 4.5
@export var sprint_speed : float = 10.0
@export var freefly_speed : float = 25.0

var move_speed : float = 0.0
var freeflying : bool = false
var input_dir: Vector2 = Vector2.ZERO

func _on_jump():
	if can_jump and is_on_floor():
		velocity.y = jump_velocity

func _on_freefly():
	pass

func _physics_process(delta: float):
	
	var move_dir: Vector3 = Vector3.ZERO
	
	### Apply gravity to velocity
	if has_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta
	
	### Check for player or AI and set controls
	if owner.is_in_group('player'):
		if input_dir != Vector2.ZERO:
			move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
		### Freefly debug component
		#if freeflying:
			#var motion = (head.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			#motion *= freefly_speed * delta
			#move_and_collide(motion)
			#return

# Apply desired movement to velocity
	if can_move:
			if move_dir:
				velocity.x = move_dir.x * move_speed
				velocity.z = move_dir.z * move_speed
			else:
				velocity.x = move_toward(velocity.x, 0, move_speed)
				velocity.z = move_toward(velocity.z, 0, move_speed)
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
