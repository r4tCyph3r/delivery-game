extends Node3D
class_name InventoryComponent

@onready var hud: Control = $"../PlayerInputComponent/MovementComponent/HUDCanvasLayer/HUD"
@onready var wallet: WalletComponent = $WalletComponent

@onready var bank: float = 0
@onready var current_items: Array

func _ready() -> void:
	for loc in get_tree().get_nodes_in_group('DeliveryLocations'):
		loc.connect('update_wallet', _on_wallet_update)

func _on_wallet_update(money):
	wallet.set_money(money)
	hud.update_wallet_counter(wallet.balance)
