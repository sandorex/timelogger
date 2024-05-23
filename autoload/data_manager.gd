extends Node



#var timelog: Timelog = Timelog.new()

#func read_data():
	#pass

#func save_data():
	#var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	#file.store_var(self.days, true)
	#var json_string := JSON.stringify(self.days, "\t")
	#var json_string := self.data_store.to_json()
	#print("got: ", json_string)
	#file.store_string(json_string)
	
#func load_all_data() -> Dictionary:
	#if not FileAccess.file_exists(self.DATA_SAVE_PATH):
		#return {}
	#
	#var save_file = FileAccess.open(self.DATA_SAVE_PATH, FileAccess.READ)
	#if not save_file:
		#return {}
	#
	#var raw_json = save_file.get_as_text()
	#if not raw_json:
		#return {}
#
	#var data = JSON.parse_string(raw_json)
	#if not data:
		#return {}
#
	#if not is_instance_of(data, TYPE_DICTIONARY):
		#return {}
#
	#return data
#
### Overwrites key in data with value
#func save_data(key: String, value: Variant):
	#var current_data = self.load_all_data()
	#var save_file: FileAccess = FileAccess.open(self.DATA_SAVE_PATH, FileAccess.WRITE)
	#current_data[key] = value
	#var json_string = JSON.stringify(current_data)
	#
	#save_file.seek(0)
	#save_file.store_string(json_string)
#
### Returns key in data or default_value if non-existant
#func load_data(key: String, default_value: Variant = null) -> Variant:
	#var data = self.load_all_data()
	#if not data:
		## this may mask internal error
		#return default_value
	#
	#return data.get(key, default_value)
