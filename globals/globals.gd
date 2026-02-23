extends Node

var items: Dictionary[int, bool]
var saved_items: Dictionary[int, bool]

var active_checkpoint: Vector2
var checkpoint_level: Node2D
var level: String

func _ready() -> void:
	for i: int in range(1,100):
		items[i] = false
	
	saved_items = items

func change_level() -> void:
	level = checkpoint_level.scene_file_path
	get_tree().change_scene_to_file(level)
