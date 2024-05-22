extends RefCounted
class_name DateTime

static func _pad_time(num: int) -> String:
	if num <= 9:
		return "0" + str(num)
	else:
		return str(num)

static func humanize_time(time: int, minimal: bool = false) -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(time)
	
	if minimal:
		var output := ""

		if date_dict.hour > 0:
			output += _pad_time(date_dict.hour) + "h "
		
		if date_dict.minute > 0:
			output += _pad_time(date_dict.minute) + "m "
			
		if date_dict.second > 0:
			output += _pad_time(date_dict.second) + "s"
		
		return output
	else:
		return _pad_time(date_dict.hour) + "h " + _pad_time(date_dict.minute) + "m " + _pad_time(date_dict.second) + "s"

