extends Control

@onready var money_counter: NinePatchRect = $MoneyCounter

#Resets money on init, needs adjusting when save files exist
func _ready() -> void:
	money_counter.label.text = '0'

# Updates hud txt to display cash on player
func update_wallet_counter(money):
	money_counter.label.text = '£%.2f' % money
