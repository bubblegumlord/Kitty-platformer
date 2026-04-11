extends Area2D

@export var id: int
@export_multiline var label_text: String

var activated: bool = false
var timer: float
var text_show: Tween
var text_length: float

@onready var label: RichTextLabel = $Label

func _ready() -> void:
	if Globals.tutorial_labels[id] == false:
		label.visible_characters = 0
	else:
		label.visible_characters = label_text.length()
	label.text = label_text
	text_length = label_text.length()
	timer = text_length / 25
	visible = true

func _on_area_entered(_area: Area2D) -> void:
	if not activated and Globals.tutorial_labels[id] == false:
		Globals.tutorial_labels[id] = true
		activated = true
		text_show = get_tree().create_tween()
		text_show.tween_property(label, "visible_characters", text_length, timer)
