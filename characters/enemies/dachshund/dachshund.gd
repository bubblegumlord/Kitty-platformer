extends Area2D

const MOVE_RANGE: int = 200

@export var direction: int

var retract: bool = false
var rad_dir: float
var move_vector: Vector2
var move: Tween
var new_position: Vector2

func _ready() -> void:
	if direction % 90 != 0:
		push_warning("Jamnik %s niewłaściwy kierunek" % global_position)
	
	rad_dir = deg_to_rad(direction)
	move_vector = Vector2(cos(rad_dir), sin(rad_dir))
	new_position = move_vector * MOVE_RANGE

func _on_timer_timeout() -> void:
	if not retract:
		retract = true
		move = get_tree().create_tween()
		move.tween_property(self, "global_position", global_position + new_position, 0.5)
	else:
		retract = false
		move = get_tree().create_tween()
		move.tween_property(self, "global_position", global_position - new_position, 0.5)
