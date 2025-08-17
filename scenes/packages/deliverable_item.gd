extends RigidBody3D
class_name DeliverableItem
# Used for:
# Storing information when instantiated
# Initialising the object
# Destroying the object and storing the data
# Handling interactions


signal add_quest


@onready var hitbox: CollisionShape3D = $HitboxComponent
@onready var texture: MeshInstance3D = $PackageMesh
@onready var deliverable: DeliverableComponent = $DeliverableComponent
@onready var interact: InteractionComponent = $InteractionComponent


@export var stats: PackageStats


var package_name: String
var weight: float
var value: float
var can_interact : bool
var can_deliver: bool
var interact_type


func _ready() -> void:
	## Item defined via resource to be available on instantiation
	package_name = stats.package_name
	weight = stats.weight
	value = stats.value
	texture.mesh = stats.mesh
	hitbox.shape = stats.collider
	interact.can_interact = stats.can_interact
	deliverable.can_deliver = stats.can_deliver
	interact.interact_prompt = stats.interact_prompt
	interact_type = stats.interact_type
	interact.connect('interaction', _on_interact)


func _on_interact():
	match interact_type:
		0:
			pass
			#destroy_and_store()
		1:
			pass


# Called when the delivery has succeeded and the package information needs storing
func destroy_and_store(destination):
	var package_data = DeliveredPackageData.create(package_name, destination, value)
	self.queue_free()
	return package_data
