extends Control

@onready var name_label: Label = %NameLabel
@onready var time_label: Label = %TimeLabel

func init_from(log_collection: LogCollection):
	self.ready.connect(
		func():
			self.name_label.text = log_collection.name
			
			# NOTE: this is kinda expensive to compute so may have to be redone in the future
			var total_work := log_collection.get_total_time(LogEntry.Work)
			var total_break := log_collection.get_total_time(LogEntry.Break)
			var total := total_work + total_break
			
			# calculate percentage
			var total_work_perc := (float(total_work) / float(total)) * 100
			var total_break_perc := (float(total_break) / float(total)) * 100

			self.time_label.text = (
				DateTime.humanize_time(total_work) + " / " + DateTime.humanize_time(total_break) + "\n" +
				str(int(total_work_perc)) + " % / " + str(int(total_break_perc)) + " %"
			)
			,
		CONNECT_ONE_SHOT
	)
	
	return self
