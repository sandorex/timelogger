extends RefCounted
class_name LogCalendar

const FILE_SAVE_PATH = "user://timelog"

var log_collections: Array[LogCollection] = []

func get_last_collection() -> LogCollection:
	if self.log_collections.size() > 0:
		return self.log_collections[-1]
	else:
		return null

func save_to_file(file: FileAccess) -> void:
	file.store_64(self.log_collections.size())
	for log_collection in self.log_collections:
		log_collection.save_to_file(file)

static func load_from_file(file: FileAccess) -> LogCalendar:
	var log_calendar := LogCalendar.new()
	for i in file.get_64():
		log_calendar.log_collections.append(LogCollection.load_from_file(file))
	
	return log_calendar

func save() -> void:
	var file: FileAccess = FileAccess.open(FILE_SAVE_PATH, FileAccess.WRITE)
	self.save_to_file(file)

static func try_to_load_saved() -> LogCalendar:
	if FileAccess.file_exists(FILE_SAVE_PATH):
		var file: FileAccess = FileAccess.open(FILE_SAVE_PATH, FileAccess.READ)
		return load_from_file(file)
	
	return LogCalendar.new()
