extends Node

const file_path := "user://timelog"

class Log:
	var time: int
	var text: String
	
	static func create(text: String, time: int = 0) -> Log:
		if time == 0:
			time = Time.get_unix_time_from_system()
		
		var log = Log.new()
		log.time = time
		log.text = text
		return log

class Day:
	var date: int
	var logs: Array[Log] = []

	static func create(date: int = 0) -> Day:
		if date == 0:
			date = Time.get_unix_time_from_system()
		
		var day = Day.new()
		day.date = date
		return day

	func total_time() -> int:
		var total = 0
		for log in self.logs:
			total += log.time
		
		return total
	
	func get_last_log_time() -> int:
		var last_log = self.logs[-1]
		if last_log:
			return last_log.time
		
		return 0

class DataStore:
	var days: Dictionary = {}
	
	func get_day(date: int) -> Day:
		var date_dict := Time.get_datetime_dict_from_unix_time(date)
		return self.days.get(str(date_dict.year) + str(date_dict.month) + str(date_dict.day))
	
	func get_today() -> Day:
		var today_date := Time.get_datetime_dict_from_system()
		var today_datestamp := str(today_date.year) + str(today_date.month) + str(today_date.day)
		var today = self.days.get(today_datestamp)
		if today:
			return today
		
		# create the day
		today = Day.create()
		self.days[today_datestamp] = today
		return today

var data_store: DataStore = DataStore.new()

func read_data():
	pass

func save_data():
	pass
