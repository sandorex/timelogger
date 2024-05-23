extends RefCounted
class_name LogCollection

signal log_entry_added(log_entry: LogEntry)

var name: String
var log_entries: Array[LogEntry] = []

func get_last_entry() -> LogEntry:
	if self.log_entries.size() > 0:
		return self.log_entries[-1]
	
	return null

func add(log_entry: LogEntry):
	# update elapsed time if there are more entries
	var last_log_entry = self.get_last_entry()
	if last_log_entry:
		log_entry.elapsed_time = log_entry.creation_date - last_log_entry.creation_date
	
	self.log_entries.append(log_entry)
	self.log_entry_added.emit(log_entry)

func get_total_time(type: int = -1) -> int:
	var total = 0
	
	if type == -1:
		# sum everything
		for log_entry: LogEntry in self.log_entries:
			total += log_entry.elapsed_time
	else:
		# filter specific type
		for log_entry: LogEntry in self.log_entries:
			if log_entry.type == type:
				total += log_entry.elapsed_time
	
	return total

func save_to_file(file: FileAccess) -> void:
	file.store_pascal_string(self.name)
	file.store_64(self.log_entries.size())
	for log_entry in self.log_entries:
		log_entry.save_to_file(file)
	
static func load_from_file(file: FileAccess) -> LogCollection:
	var log_collection := LogCollection.new()
	log_collection.name = file.get_pascal_string()
	for i in file.get_64():
		# NOTE: using add so elapsed_time is calculated
		log_collection.add(LogEntry.load_from_file(file))

	return log_collection

static func create_collection(collection_name: String, entries: Array[LogEntry] = []) -> LogCollection:
	var log_collection := LogCollection.new()
	log_collection.name = collection_name
	log_collection.log_entries = entries
	return log_collection
