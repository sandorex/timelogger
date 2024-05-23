extends RefCounted
class_name DateTime

static func humanize_time(time: int, show_seconds := false) -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(time)
	
	var output := ""

	if date_dict.hour > 0:
		output += str(date_dict.hour) + "h "
	
	if date_dict.minute > 0:
		output += str(date_dict.minute) + "m "
		
	if show_seconds and date_dict.second > 0:
		output += str(date_dict.second) + "s"
		
	return output.rstrip(" ")
