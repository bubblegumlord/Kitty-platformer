extends Node

signal CHANGE_LEVEL()
signal RESET

var items: Dictionary[int, bool]
var saved_items: Dictionary[int, bool]

var checkpoint_position: Vector2
var checkpoint_level: String
var level: String

func _ready() -> void:
	for i: int in range(1,100):
		items[i] = false
	
	saved_items = items
