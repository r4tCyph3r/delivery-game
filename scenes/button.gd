extends StaticBody3D


@onready var interact: InteractionComponent = $InteractionComponent
@onready var anim_player: AnimationPlayer = $AnimationPlayer


@onready var package_timer = $package_timer


@onready var package_spawner = $DeliverySpawnerComponent
@onready var package_spawn_location = $spawnpoint


func _ready() -> void:
	interact.connect('interaction', _on_interact)


func _on_interact():
	anim_player.play('press')
	if package_timer.is_stopped():
		package_spawner.new_package()
		package_timer.start()
	else:
		print("Too fast " , package_timer.time_left, 'seconds left')
