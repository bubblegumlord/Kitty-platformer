@icon("uid://c8nkjw2ct0ln0")

extends Node2D
class_name Level

@export var entrance_array: Array[Vector2]
@export var player: Player

func set_player_pos(entrance_id: int) -> void:
	player.global_position = entrance_array[entrance_id]
