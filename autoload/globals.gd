extends Node

var SCENE_MENU := load("res://scenes/ui/menu.tscn")
var SCENE_VIEW_CALENDAR := load("res://scenes/ui/view_calendar.tscn")
var SCENE_VIEW_COLLECTION := load("res://scenes/ui/view_collection.tscn")

var SCENE_EDIT_COLLECTION := load("res://scenes/ui/edit_collection.tscn")

var SCENE_UI_LOG_ENTRY_CONTROL = load("res://scenes/ui_element/log_entry_control.tscn")
var SCENE_UI_LOG_COLLECTION_CONTROL = load("res://scenes/ui_element/log_collection_control.tscn")

var calendar: LogCalendar
var collection: LogCollection

func _init() -> void:
	self.calendar = LogCalendar.try_to_load_saved()
