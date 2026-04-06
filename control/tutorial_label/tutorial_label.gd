extends Area2D

@export_multiline var label_text: String

var activated: bool = false
var timer: float
var text_show: Tween
var text_length: float

@onready var label: RichTextLabel = $Label

func _ready() -> void:
	visible = true
	label.text = label_text
	label.visible_characters = 0
	text_length = label_text.length()
	timer = text_length / 25

func _on_area_entered(_area: Area2D) -> void:
	if not activated:
		activated = true
		text_show = get_tree().create_tween()
		text_show.tween_property(label, "visible_characters", text_length, timer)
