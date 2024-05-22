extends RefCounted
class_name DateTime

static func _pad_time(num: int) -> String:
	if num <= 9:
		return "0" + str(num)
	else:
		return str(num)

static func humanize_time(time: int) -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(time)
	return _pad_time(date_dict.hour) + "h " + _pad_time(date_dict.minute) + "m " + _pad_time(date_dict.second) + "s"

