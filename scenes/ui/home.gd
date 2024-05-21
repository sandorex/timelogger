extends Control

@onready var date_label: Label = %DateLabel
@onready var time_elapsed_label: Label = %TimeElapsedLabel
@onready var text_edit: TextEdit = %TextEdit

var last_time: int = 0

func _ready() -> void:
	var date := Time.get_datetime_dict_from_system()
	self.date_label.text = str(date.day) + "/" + str(date.month) + "/" + str(date.year)

func _on_log_button_pressed() -> void:
	if self.last_time == 0:
		var today = DataManager.data_store.get_today()
		today.logs.append(DataManager.Log.create("Fuck"))
		self.last_time = Time.get_unix_time_from_system()
		print("saving")
	else:
		var today = DataManager.data_store.get_today()
		print(today.logs)
		#today.logs.append(DataManager.Log.create("Fuck"))
		var curr_time = Time.get_unix_time_from_system()
		var diff = curr_time - last_time
		var diff_obj := Time.get_datetime_dict_from_unix_time(diff)
		print(str(diff_obj.hour), " ", str(diff_obj.minute), " ", str(diff_obj.second))
