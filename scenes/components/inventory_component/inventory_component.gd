extends Node3D
class_name InventoryComponent

## When object is picked up, send the resource of what was assigned to the inventory

@onready var wallet: float = 0
@onready var bank: float = 0
@onready var current_items: Array

func _ready() -> void:
	for loc in get_tree().get_nodes_in_group('DeliveryLocations'):
		loc.connect('update_wallet', _on_wallet_update)

func _on_wallet_update(money):
	wallet += money
	print('+ £',money,' your wallet now has: £', wallet)
