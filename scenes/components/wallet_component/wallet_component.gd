extends Node3D
class_name WalletComponent

@onready var balance : float

# Returns current on-player cash balance
func get_money():
	return balance

# Performs changes against current stored cash amount on the player
func set_money(changed_amount):
	balance += changed_amount
