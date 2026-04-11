extends Node

signal LOAD_LEVEL(level_path: String)
signal RESET_LEVEL
signal RESET_PLAYER

var tutorial_labels: Array = [false, false, false, false, false]

var items: Dictionary[int, bool]
var saved_items: Dictionary[int, bool]

var active_checkpoint_id: int
var checkpoint_position: Vector2
var checkpoint_level: String
var level: String

var can_reset: bool = false

var jump_count: int = 5

func _ready() -> void:
	for i: int in range(1,100):
		items[i] = false
	
	saved_items = items

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RESET") and can_reset:
		RESET_LEVEL.emit()
