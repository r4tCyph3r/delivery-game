class_name PackageStats extends Resource

enum ITEM_INTERACT_TYPE {pickup, grab}

@export var package_name: String
@export var interact_type: ITEM_INTERACT_TYPE
@export var weight: float
@export var value: float
@export var mesh: Mesh
@export var collider: Shape3D
@export var interact_prompt : String
@export var can_interact : bool
@export var can_deliver: bool
