extends Control

# TODO on click / tap show read-only view of the log
# TODO remove the trash button to simplify things

var log_collection: LogCollection

@onready var name_label: Label = %NameLabel
@onready var time_label: Label = %TimeLabel

func init_from(collection: LogCollection):
	self.log_collection = collection
	
	return self

func _ready() -> void:
	self.name_label.text = self.log_collection.name

	var total_work := self.log_collection.get_total_time(LogEntry.Work)
	var total_break := self.log_collection.get_total_time(LogEntry.Break)
	var total := total_work + total_break
	
	# do not show anything if there is no time
	if total == 0:
		self.time_label.text = ""
	else:
		# calculate percentage
		var total_work_perc := (float(total_work) / float(total)) * 100
		var total_break_perc := (float(total_break) / float(total)) * 100

		self.time_label.text = (
			DateTime.humanize_time(total_work) + " / " + DateTime.humanize_time(total_break) + "\n" +
			str(int(total_work_perc)) + " % / " + str(int(total_break_perc)) + " %"
		)

func _on_button_pressed() -> void:
	Globals.calendar.log_collections.erase(self.log_collection)
	Globals.calendar.save()
	self.queue_free()
