extends Area2D

@export var timer: float = 1.0
@export_multiline var label_text: String

var text_show: Tween
var text_length: int

@onready var label: RichTextLabel = $Label

func _ready() -> void:
	label.text = label_text
	label.visible_characters = 0
	text_length = label_text.length()

func _on_body_entered(_body: Node2D) -> void:
	text_show = get_tree().create_tween()
	text_show.tween_property(label, "visible_characters", text_length, timer)
