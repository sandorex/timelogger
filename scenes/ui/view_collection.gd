extends Control

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

var today: LogCollection

func _notification(what: int) -> void:
	match what:
		# TODO android back button

		# do not waste resources when window is not focused
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			get_tree().paused = false
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			get_tree().paused = true

func _init() -> void:
	self.today = Globals.log_calendar.get_last_collection()
	if not self.today:
		self.today = LogCollection.create_collection("today?")
		Globals.log_calendar.log_collections.append(self.today)
	
	self.today.log_entry_added.connect(self._on_log_added)

func _ready() -> void:
	self.date_label.text = self.today.name
	
	# create old logs
	for log_entry in self.today.log_entries:
		self.container.add_child(LogEntryControl.create_from_log(log_entry))

	self.refresh_screen()
	
	# focus line edit
	self.line_edit.grab_focus.call_deferred()

func _on_log_added(new_log: LogEntry) -> void:
	self.container.add_child(LogEntryControl.create_from_log(new_log))
	self.refresh_screen()

func refresh_screen() -> void:
	var last_entry := self.today.get_last_entry()
	if last_entry:
		self.time_elapsed_label.text = DateTime.humanize_time(
			int(Time.get_unix_time_from_system() - last_entry.creation_date)
		)
	else:
		self.time_elapsed_label.text = ""

func _process(_delta: float) -> void:
	self.refresh_screen()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		# push log on double tap
		if event.double_tap:
			if self.line_edit.text:
				self.push_log()
	else:
		if event.is_pressed():
			# allow pushing empty log with force-enter action
			if event.is_action("force-enter"):
				self.push_log()
			elif event.is_action("enter"):
				if self.line_edit.text:
					self.push_log()

func push_log() -> void:
	self.today.add(LogEntry.create_entry(self.line_edit.text))
	self.line_edit.text = ""
	Globals.log_calendar.save()

func _on_line_edit_text_changed(new_text: String) -> void:
	# highlight that the log is a break by making line edit transparent
	if new_text.begins_with(" "):
		self.line_edit.modulate.a = 0.8
	else:
		self.line_edit.modulate.a = 1
