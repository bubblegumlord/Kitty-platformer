extends RichTextLabel

var text_show: Tween

@onready var timer: Timer = $Timer

func _ready() -> void:
	visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("JUMP") and Globals.jump_count == 1:
		visible_characters = 0
		visible = true
		text_show = get_tree().create_tween()
		text_show.tween_property(self, "visible_characters", text.length(), 2)
		timer.start()

func _on_timer_timeout() -> void:
	visible = false
