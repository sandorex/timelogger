extends Control

@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready():
	for log_collection: LogCollection in Globals.log_calendar.log_collections:
		container.add_child(Globals.SCENE_UI_LOG_COLLECTION_CONTROL.instantiate().init_from(log_collection))
