extends Control

@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready():
	for collection: LogCollection in Globals.calendar.log_collections:
		container.add_child(Globals.SCENE_UI_LOG_COLLECTION_CONTROL.instantiate().init_from(collection))

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_MENU)
