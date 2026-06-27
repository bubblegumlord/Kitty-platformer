extends Node2D

var path_to_level: PackedScene
var loaded_level: Level

func _ready() -> void:
	Globals.LOAD_LEVEL.connect(load_level)
	Globals.RESET_LEVEL.connect(reset_level)

func load_level(level_path: String, entrance_id: int) -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(level_path)
	loaded_level = path_to_level.instantiate()
	loaded_level.set_player_pos(entrance_id)
	call_deferred("add_child", loaded_level)

func reset_level() -> void:
	for child in get_children():
		child.queue_free()
	
	path_to_level = load(Globals.checkpoint_level)
	loaded_level = path_to_level.instantiate()
	call_deferred("add_child", loaded_level)
	await get_tree().create_timer(0.05).timeout
	Globals.RESET_PLAYER.emit()
