extends Control
class_name LogCollectionControl

static func create_from_collection(log_collection: LogCollection) -> LogCollectionControl:
	var log_collection_control := LogCollectionControl.new()
	
	return log_collection_control
#
#func _from_collection(log_collection: LogCollection):
	#pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
