extends Control

@onready var version_label: Label = %VersionLabel
@onready var test_button: Button = %TestButton

func _notification(what: int) -> void:
	match what:
		# quit in menu with back button
		NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().quit()

func _ready() -> void:
	self.version_label.text = "Version " + ProjectSettings.get_setting("application/config/version", "420blazeit")

	if OS.has_feature("editor"):
		self.version_label.text += " (Editor)"
		self.test_button.visible = true
	elif OS.has_feature("debug"):
		self.version_label.text += " (Debug)"

func _on_last_button_pressed() -> void:
	# try to load last collection if not then just create one for today
	Globals.collection = Globals.calendar.get_last_collection()
	if not Globals.collection:
		Globals.collection = LogCollection.create_collection(Time.get_date_string_from_system())
		Globals.calendar.log_collections.append(Globals.collection)
	
	# change scene
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_EDIT_COLLECTION)

func _on_view_all_button_pressed() -> void:
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_VIEW_CALENDAR)

func _on_new_button_pressed() -> void:
	# try to load last collection if not then just create one for today
	Globals.collection = LogCollection.create_collection(Time.get_date_string_from_system())
	Globals.calendar.log_collections.append(Globals.collection)
	
	# change scene
	get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_EDIT_COLLECTION)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_test_button_pressed() -> void:
	print("unimplemented atm..")
	# TODO do test data so i can test without waiting
