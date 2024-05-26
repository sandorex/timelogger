extends Node2D

var SCENE_MENU := load("res://scenes/ui/menu.tscn")
var SCENE_VIEW_CALENDAR := load("res://scenes/ui/view_calendar.tscn")
var SCENE_VIEW_COLLECTION := load("res://scenes/ui/view_collection.tscn")

var SCENE_EDIT_COLLECTION := load("res://scenes/ui/edit_collection.tscn")

var SCENE_UI_LOG_ENTRY_CONTROL = load("res://scenes/ui_element/log_entry_control.tscn")
var SCENE_UI_LOG_COLLECTION_CONTROL = load("res://scenes/ui_element/log_collection_control.tscn")

var calendar: LogCalendar
var collection: LogCollection

var scene_back: PackedScene

func _notification(what: int) -> void:
	match what:
		# go to menu on back button
		NOTIFICATION_WM_GO_BACK_REQUEST:
			self.go_back()

		# do not waste resources when window is not focused
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			get_tree().paused = false
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			get_tree().paused = true

func _init() -> void:
	self.calendar = LogCalendar.try_to_load_saved()
	
func go_back() -> void:
	# go back if set or default to menu
	if self.scene_back:
		get_tree().change_scene_to_packed.call_deferred(self.scene_back)
	else:
		get_tree().change_scene_to_packed.call_deferred(self.SCENE_MENU)
	
	# reset after use
	self.scene_back = null
