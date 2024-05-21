extends Node2D

@onready var time_label: Label = %TimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# TODO run this only when window is visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time = Time.get_time_dict_from_system()
	# TODO pad numbers 09 instead of 9
	self.time_label.text = str(time.hour) + ":" + str(time.minute)
