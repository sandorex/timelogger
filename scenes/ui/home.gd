extends Control

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var log_label: Label = %LogLabel

# TODO redo the log label so its prettier and there is difference between text
# and time, at least with color, whether its work or not

var today_store: DataManager.Day

func _ready() -> void:
	var date := Time.get_datetime_dict_from_system()
	self.date_label.text = str(date.day) + "/" + str(date.month) + "/" + str(date.year)
	
	# create the day timelog
	self.today_store = DataManager.data_store.get_today()
	self.today_store.day_changed.connect(self._on_logs_changed)

	today_store.add_log("hello")
	await get_tree().create_timer(2).timeout
	today_store.add_log("world")

func _on_logs_changed() -> void:
	self.log_label.text = ""
	
	for log in self.today_store.logs:
		if log.time_elapsed == 0:
			self.log_label.text += log.text + "\n"
			continue
		
		if log.text:
			self.log_label.text += log.text + " \t(" + DateTime.humanize_time(log.time_elapsed) + ")\n"
		else:
			# nicer display without time
			self.log_label.text += "(" + DateTime.humanize_time(log.time_elapsed) + ")\n"

func _process(_delta: float) -> void:
	# update running counter
	if self.today_store.logs.size() > 0:
		self.time_elapsed_label.text = DateTime.humanize_time(
			Time.get_unix_time_from_system() - self.today_store.get_last_log_time()
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
