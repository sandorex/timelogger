extends Control
class_name LogControl

const SCENE = preload("res://scenes/ui_element/log.tscn")

var log: DataManager.Log

@onready var color_rect: ColorRect = $ColorRect
@onready var text_label: Label = %TextLabel
@onready var time_label: Label = %TimeLabel

static func create_from_log(log: DataManager.Log) -> LogControl:
	var node := SCENE.instantiate()
	node.log = log

	return node

func _ready():
	self.text_label.text = log.text
	
	if self.log.time_elapsed != 0:
		self.time_label.text = DateTime.humanize_time(log.time_elapsed, true)
	else:
		self.time_label.visible = false

	# dim logs that are not work
	if not log.is_work:
		self.modulate.a = 0.5
