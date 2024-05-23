extends Node

var log_calendar: LogCalendar

func _init() -> void:
	self.log_calendar = LogCalendar.try_to_load_saved()
