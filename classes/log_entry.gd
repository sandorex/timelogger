extends RefCounted
class_name LogEntry

enum {
	Work,
	Break
}

## Creation date in UNIX time
var creation_date: int

## Elapsed time since last log entry, DO NOT SERIALIZE THIS
var elapsed_time: int = 0

var entry_text: String

var type: int = Work

# NOTE: intentionally not saving or loading elapsed_time
func save_to_file(file: FileAccess) -> void:
	file.store_64(self.creation_date)
	file.store_pascal_string(self.entry_text)
	file.store_32(self.type)

static func load_from_file(file: FileAccess) -> LogEntry:
	var log_entry = LogEntry.new()
	log_entry.creation_date = file.get_64()
	log_entry.entry_text = file.get_pascal_string()
	log_entry.type = file.get_32()
	
	return log_entry

static func create_entry(text: String) -> LogEntry:
	var log_entry = LogEntry.new()
	log_entry.creation_date = Time.get_unix_time_from_system()
	log_entry.entry_text = text.lstrip(" ")
	
	if text.begins_with(" "):
		log_entry.type = Break
	
	return log_entry
