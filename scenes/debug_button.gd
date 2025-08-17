extends StaticBody3D
class_name DebugButton

@onready var interact: InteractionComponent = $InteractionComponent

signal day_ended

func _ready() -> void:
	interact.connect('interaction', _on_interact)

func _on_interact():
	#debug_delivered_array()
	debug_cashout()
	
func debug_delivered_array():
	#Used to debug packages being stored into resources correctly
	var delivery_locations: Array = get_tree().get_nodes_in_group('DeliveryLocations')
	var count = 0
	for loc in delivery_locations:
		print('####################')
		print(loc.location_name)
		for package in loc.delivered_packages:
			print('----------------')
			print(package.package)
			print(package.value)
			print(package.destination)
			count += 1
		print(count)

func debug_cashout():
	#purpose of cashout is when the button is pressed to deliver all money to player for packages delivered throughout the day
	emit_signal('day_ended')
