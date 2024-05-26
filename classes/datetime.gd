extends RefCounted
class_name DateTime

static func humanize_time(unix_time: int) -> String:
	var days := float(unix_time) / 86400
	var hours := fmod(unix_time, 86400) / 3600
	var minutes := fmod(fmod(unix_time, 86400), 3600) / 60
	
	var days_i := int(days)
	var hours_i := int(hours)
	var minutes_i := int(minutes)
	
	var output: String = ""
	
	if days_i > 0:
		output += str(days_i) + "d "
	
	if hours_i > 0:
		output += str(hours_i) + "h "
	
	if minutes_i > 0:
		output += str(minutes_i) + "m"

	return output.rstrip(" ")
