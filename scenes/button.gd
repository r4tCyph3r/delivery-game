extends StaticBody3D

signal request_package

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var int_comp: InteractionComponent = $InteractionComponent
@onready var package_spawn = $spawnpoint
@onready var package_timer = $package_timer
func _ready() -> void:
	int_comp.connect('interaction', _on_interact)

func _on_interact():
	anim_player.play('press')
	if package_timer.is_stopped():
		emit_signal('request_package', 'parcel' ,package_spawn.global_position)
		package_timer.start()
	else:
		print("Too fast")
