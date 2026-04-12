extends Area2D

var can_enter: bool = false

@export var level_path: String

func _on_area_entered(_area: Area2D) -> void:
	can_enter = true

func _on_area_exited(_area: Area2D) -> void:
	can_enter = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ENTER") and can_enter:
		Globals.LOAD_LEVEL.emit(level_path)
