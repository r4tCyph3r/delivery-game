extends Node3D

var package_scene : PackedScene = preload('res://Vamp-Surv-Clone/scenes/packages/DeliverableItem.tscn')

var package_stats : Array[PackageStats] = [
	preload("res://Vamp-Surv-Clone/resources/deliverables/package_parcel.tres"),
	preload('res://Vamp-Surv-Clone/resources/deliverables/package_newspaper.tres'),
	preload('res://Vamp-Surv-Clone/resources/deliverables/package_tv.tres')
]

func new_package():
	var pack = package_stats.pick_random()
	var spawned_package : DeliverableItem = package_scene.instantiate()
	spawned_package.stats = pack
	get_tree().root.add_child(spawned_package)
