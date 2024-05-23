extends Control

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

# TODO move log calendar to a global autoloaded object as all scenes will use it
var log_calendar := LogCalendar.try_to_load_saved()
var today: LogCollection

# TODO make sure to save often
func _notification(what: int) -> void:
	match what:
		# do not waste resources when window is not focused
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			#print_debug("focus in")
			get_tree().paused = false
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			#print_debug("focus out")
			get_tree().paused = true

func _init() -> void:
	self.today = self.log_calendar.get_last_collection()
	if not self.today:
		self.today = LogCollection.create_collection("today?")
		self.log_calendar.log_collections.append(self.today)
	
	self.today.log_entry_added.connect(self._on_log_added)

func _ready() -> void:
	self.date_label.text = self.today.name
	
	# create old logs
	for log_entry in self.today.log_entries:
		self.container.add_child(LogControl.create_from_log(log_entry))

	self.refresh_screen()

func _on_log_added(new_log: LogEntry) -> void:
	self.container.add_child(LogControl.create_from_log(new_log))
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

# TODO touch double tap to push log entry
func _input(event: InputEvent) -> void:
	# allow pushing empty log with force-enter action
	if event.is_action("force-enter") and event.is_pressed():
		self.push_log()
	elif event.is_action("enter") and event.is_pressed():
		if self.line_edit.text:
			self.push_log()
	
	if Input.is_key_pressed(KEY_C):
		print("saved calendar")
		self.log_calendar.save()
		#self.timelog.save_timelog()

func push_log() -> void:
	self.today.add(LogEntry.create_entry(self.line_edit.text))
	self.line_edit.text = ""

func _on_line_edit_text_changed(new_text: String) -> void:
	# highlight that the log is a break by making line edit transparent
	if new_text.begins_with(" "):
		self.line_edit.modulate.a = 0.8
	else:
		self.line_edit.modulate.a = 1
