extends Node2D

const PACKED_LEVEL = preload("uid://ddbxmdi4cpi8b")

var start_level: Node2D
var path_to_level: PackedScene
var loaded_level: Node2D

func _ready() -> void:
	Globals.CHANGE_LEVEL.connect(level_transition)
	Globals.RESET_LEVEL.connect(on_reset)
	start_level = PACKED_LEVEL.instantiate()
	call_deferred("add_child", start_level)

func on_reset() -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(Globals.checkpoint_level)
	loaded_level = path_to_level.instantiate()
	call_deferred("add_child", loaded_level)
	await get_tree().create_timer(0.1).timeout
	Globals.RESET_OBJECTS.emit()

func level_transition(level_path: String) -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(level_path)
	loaded_level = path_to_level.instantiate()
	call_deferred("add_child", loaded_level)
