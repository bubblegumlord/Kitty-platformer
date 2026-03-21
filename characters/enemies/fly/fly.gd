extends Area2D

var time: float = 0.0
var speed: float = 3
var distance_from_center: float = 50

func _physics_process(delta: float) -> void:
	time += delta
	var angle: float = speed * time
	var move_rotation: Vector2 = Vector2(cos(angle), sin(angle))
	position = move_rotation * distance_from_center
