extends Area2D

const MOVE_RANGE: int = 48

@export var direction: Vector2

var retract: bool = false
var move: Tween

@onready var new_position: Vector2 = direction * MOVE_RANGE

func _ready() -> void:
	rotate(atan2(direction.y, direction.x))

func _on_timer_timeout() -> void:
	if not retract:
		retract = true
		move = get_tree().create_tween()
		move.tween_property(self, "global_position", global_position + new_position, 0.3)
	else:
		retract = false
		move = get_tree().create_tween()
		move.tween_property(self, "global_position", global_position - new_position, 0.3)
