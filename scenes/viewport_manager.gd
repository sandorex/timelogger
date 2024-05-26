extends Node

# changes control node size to adapt to android

@export var node: Control
@export var adapt_notch: bool = false

var default_size: Vector2

func _ready() -> void:
	# adapt to virtual keyboard only when available
	self.set_process(DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD))
	
	# adapt to notch cutout on android
	if OS.has_feature("android") and self.adapt_notch:
		var notch_height := DisplayServer.get_display_safe_area().position.y / self.node.get_viewport_transform().get_scale().y
		self.node.set_deferred("size.y", self.node.size.y - notch_height)
		#self.node.size.y -= notch_height
		self.node.position.y = notch_height
	
	# save node size
	self.default_size = self.node.size

func _process(_delta: float):
	# NOTE: this code responds to keyboard show / hide and resized the node accordingly
	# the viewport may be scaled so divide by scale
	var keyboard_height := DisplayServer.virtual_keyboard_get_height() / self.node.get_viewport_transform().get_scale().y
	self.node.size.y = self.default_size.y - keyboard_height
