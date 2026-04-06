extends Node2D

var path_to_level: PackedScene
var loaded_level: Level

func _ready() -> void:
	Globals.LOAD_LEVEL.connect(level_transition)
	Globals.RESET_LEVEL.connect(on_reset)

func level_transition(level_path: String) -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(level_path)
	loaded_level = path_to_level.instantiate()
	call_deferred("add_child", loaded_level)

func on_reset() -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(Globals.checkpoint_level)
	loaded_level = path_to_level.instantiate()
	call_deferred("add_child", loaded_level)
	await get_tree().create_timer(0.05).timeout
	Globals.jump_count = 5
	Globals.RESET_PLAYER.emit()
