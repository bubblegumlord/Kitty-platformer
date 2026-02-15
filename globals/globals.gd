extends Node

const GRAVITY: int = 400

var items: Dictionary[int, bool]
var saved_items: Dictionary[int, bool]

func _ready() -> void:
	for i: int in range(1,100):
		items[i] = false
	saved_items = items
