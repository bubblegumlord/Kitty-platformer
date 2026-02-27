extends Area2D

@export var level_path: String

func _on_area_entered(_area: Area2D) -> void:
	Globals.CHANGE_LEVEL.emit(level_path)
