extends Control

@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready():
	for collection: LogCollection in Globals.calendar.log_collections:
		container.add_child(Globals.SCENE_UI_LOG_COLLECTION_CONTROL.instantiate().init_from(collection))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		Globals.go_back()
