extends Control

@onready var version_label: Label = %VersionLabel

func _ready() -> void:
	self.version_label.text = "Version " + ProjectSettings.get_setting("application/config/version", "420blazeit")

	if OS.has_feature("editor"):
		self.version_label.text += " (Editor)"
	elif OS.has_feature("debug"):
		self.version_label.text += " (Debug)"

func _on_last_button_pressed() -> void:
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_VIEW_COLLECTION)

func _on_view_all_button_pressed() -> void:
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_VIEW_CALENDAR)

func _on_new_button_pressed() -> void:
	# create collection and just use timestamp
	Globals.log_calendar.log_collections.append(LogCollection.create_collection(Time.get_datetime_string_from_system()))
