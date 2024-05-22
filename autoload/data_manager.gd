extends Node

const file_path := "user://timelog"

class Log:
	var date: int
	var time_elapsed: int
	var text: String
	var is_work: bool = true

class Day:
	signal day_changed
	
	var date: int
	var logs: Array[Log] = []

	static func create(date: int) -> Day:
		var day = Day.new()
		day.date = date
		return day
	
	func add_log(text: String) -> Log:
		var log = Log.new()
		
		# if prefixed with space then its a non work log
		if text.begins_with(" "):
			log.is_work = false
			log.text = text.substr(1)
		else:
			log.is_work = true
			log.text = text

		log.date = Time.get_unix_time_from_system()
		
		var last_log_date = self.get_last_log_time()
		if last_log_date != 0:
			log.time_elapsed = log.date - last_log_date
		else:
			log.time_elapsed = 0
		
		self.logs.append(log)
		
		self.day_changed.emit()
		
		return log

	func total_work_time() -> int:
		var total = 0
		for log in self.logs:
			if log.is_work:
				total += log.time
		
		return total
	
	func total_break_time() -> int:
		var total = 0
		for log in self.logs:
			if not log.is_work:
				total += log.time
		
		return total
	
	func get_last_log_time() -> int:
		# the first log cannot be timed
		if self.logs.size() == 0:
			return 0
		
		var last_log = self.logs[-1]
		if last_log:
			return last_log.date
		
		return 0

class DataStore:
	var days: Dictionary = {}
	
	func get_today() -> Day:
		var today_date := Time.get_datetime_dict_from_system()
		var today_datestamp := str(today_date.year) + str(today_date.month) + str(today_date.day)
		var today = self.days.get(today_datestamp)
		if today:
			return today
		
		# create the day
		today = Day.create(Time.get_unix_time_from_datetime_dict(today_date))
		self.days[today_datestamp] = today
		return today

var data_store: DataStore = DataStore.new()

func read_data():
	pass

func save_data():
	pass
