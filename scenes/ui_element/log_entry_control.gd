extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var text_label: Label = %TextLabel
@onready var time_label: Label = %TimeLabel

func init_from(log_entry: LogEntry):
	self.ready.connect(
		func():
			self.text_label.text = log_entry.entry_text
			self.time_label.text = DateTime.humanize_time(log_entry.elapsed_time)

			# dim logs that are breaks
			if log_entry.type == LogEntry.Break:
				self.modulate.a = 0.65
			,
		CONNECT_ONE_SHOT
	)
	
	return self
