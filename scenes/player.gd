# Requirements
# Player can move wasd
# Player can sprint
# Player collides with structures
# Player collides with objects

extends CharacterBody3D

# Define Constants
const SPRINT_SPEED = 20 # Maximum player speed in sprint state
const WALK_SPEED = 18 # Maximum speed in walking state
const ACCEL = 4.5 # how fast the player accelerates
const DEACCEL = 3.5 # how fast the player decellerates
var MOUSE_SENSITIVITY = 0.05 # Mouse Sens but can be modified hence var
const MAX_SLOPE_ANGLE

# Defined Variables
var dir = Vector3() # Direction handle
var camera
var rotation_helper

# onready check to activate camera and rot_helper
func _ready():
	pass
