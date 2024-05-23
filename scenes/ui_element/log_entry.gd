extends Control
class_name LogEntryControl

const SCENE_PATH := "res://scenes/ui_element/log_entry.tscn"

var text: String
var time: String
var type: int

@onready var color_rect: ColorRect = $ColorRect
@onready var text_label: Label = %TextLabel
@onready var time_label: Label = %TimeLabel

static func create_from_log(log_entry: LogEntry) -> LogEntryControl:
	var node: LogEntryControl = load(SCENE_PATH).instantiate()
	node.text = log_entry.entry_text
	node.time = DateTime.humanize_time(log_entry.elapsed_time)
	node.type = log_entry.type

	return node

func _ready():
	self.text_label.text = self.text
	self.time_label.text = self.time

	# dim logs that are breaks
	if self.type == LogEntry.Break:
		self.modulate.a = 0.65
