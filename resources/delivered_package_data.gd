# PackageData.gd
class_name DeliveredPackageData extends Resource

@export var package: String
@export var destination: String
@export var value: float

# Constructor for convenience
static func create(pkg: String, dest: String, val: float) -> DeliveredPackageData:
	var data = DeliveredPackageData.new()
	data.package = pkg
	data.destination = dest
	data.value = val
	return data
