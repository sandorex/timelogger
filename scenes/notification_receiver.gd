extends Node

# only purpose of this class is to receive global notifications so i do not
# have to duplicate code

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_GO_BACK_REQUEST:
			# go to menu on back button
			get_tree().change_scene_to_packed.call_deferred(Globals.SCENE_MENU)
		# do not waste resources when window is not focused
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			get_tree().paused = false
		NOTIFICATION_WM_WINDOW_FOCUS_OUT:
			get_tree().paused = true
