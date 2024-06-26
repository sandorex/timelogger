extends Control

@export var editable: bool = true

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var container: VBoxContainer = $ScrollContainer/VBoxContainer

func _init() -> void:
	Globals.collection.log_entry_added.connect(self._on_log_added)

func _ready() -> void:
	self.date_label.text = Globals.collection.name
	
	# create old logs
	for log_entry in Globals.collection.log_entries:
		self.container.add_child(Globals.SCENE_UI_LOG_ENTRY_CONTROL.instantiate().init_from(log_entry))

	self.refresh_screen()
	
	if self.editable:
		# focus line edit
		self.line_edit.grab_focus.call_deferred()
	else:
		# these are not needed for previewing
		self.line_edit.editable = false
		self.line_edit.visible = false
		self.time_elapsed_label.visible = false
		
		# just in case disable process
		self.set_process(false)
		
		# go back to view all instead of menu
		Globals.scene_back = Globals.SCENE_VIEW_CALENDAR

func _on_log_added(new_log: LogEntry) -> void:
	self.container.add_child(Globals.SCENE_UI_LOG_ENTRY_CONTROL.instantiate().init_from(new_log))
	self.refresh_screen()

func refresh_screen() -> void:
	var last_entry := Globals.collection.get_last_entry()
	if last_entry:
		self.time_elapsed_label.text = DateTime.humanize_time(
			int(Time.get_unix_time_from_system() - last_entry.creation_date)
		)
	else:
		self.time_elapsed_label.text = ""

func _process(_delta: float) -> void:
	self.refresh_screen()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		if self.line_edit.text:
			self.push_log()
	elif event.is_action_pressed("back"):
		Globals.go_back()

func push_log() -> void:
	Globals.collection.add(LogEntry.create_entry(self.line_edit.text))
	self.line_edit.text = ""
	Globals.calendar.save()

func _on_line_edit_text_changed(new_text: String) -> void:
	# highlight that the log is a break by making line edit transparent
	if new_text.begins_with(" "):
		self.line_edit.modulate.a = 0.65
	else:
		self.line_edit.modulate.a = 1
