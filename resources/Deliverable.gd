extends Resource
class_name Deliverable

enum SPAWN_LOCATION {postoffice, warehouse, fruitstand}
enum DELIVERY_CONTENTS {mail, package, fruit}
enum ITEM_INTERACT_TYPE {pickup, grab, drag}

@export var name: String
@export var type: DELIVERY_CONTENTS
@export var interact_type: ITEM_INTERACT_TYPE

## Generate weight based on interaction type
var weight: float

## Generate value based on weight, interaction type, distance
var value: float

## Address generated once instantiated
var address
