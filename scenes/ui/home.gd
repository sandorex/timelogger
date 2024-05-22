extends Control

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var log_label: Label = %LogLabel
@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

var today_store: DataManager.Day

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			#print_debug("focus in")
			get_tree().paused = false
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			#print_debug("focus out")
			get_tree().paused = true

func _ready() -> void:
	var date := Time.get_datetime_dict_from_system()
	self.date_label.text = str(date.day) + "/" + str(date.month) + "/" + str(date.year)
	
	# create the day timelog
	self.today_store = DataManager.data_store.get_today()
	self.today_store.day_changed.connect(self._on_logs_changed)

func _on_logs_changed() -> void:
	# remove children
	for child in self.container.get_children():
		child.queue_free()
	
	for log in self.today_store.logs:
		self.container.add_child(LogControl.create_from_log(log))

func _process(_delta: float) -> void:
	# update running counter
	if self.today_store.logs.size() > 0:
		self.time_elapsed_label.text = DateTime.humanize_time(
			Time.get_unix_time_from_system() - self.today_store.get_last_log_time()
			, true
		)
	else:
		self.time_elapsed_label.text = ""
	

# TODO touch double tap to push
func _input(event: InputEvent) -> void:
	# allow pushing empty log with force-enter action
	if event.is_action("force-enter") and event.is_pressed():
		self.push_log()
	elif event.is_action("enter") and event.is_pressed():
		if self.line_edit.text:
			self.push_log()

func push_log() -> void:
	self.today_store.add_log(self.line_edit.text)
	self.line_edit.text = ""

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.begins_with(" "):
		self.line_edit.modulate.a = 0.8
	else:
		self.line_edit.modulate.a = 1
