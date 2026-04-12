extends Node2D

@export var starting_level: String = "uid://bimctcm4uucni"

func _on_start_game_button_up() -> void:
	Globals.LOAD_LEVEL.emit(starting_level)
	queue_free()

func _on_quit_game_button_up() -> void:
	get_tree().quit()
