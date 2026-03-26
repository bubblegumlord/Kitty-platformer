extends Area2D

var speed: float = 1.5
var orbit_radius: float = 50
var angle: float
var offset_vector: Vector2

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var center_position: Vector2 = global_position

func _physics_process(delta: float) -> void:
	angle += speed * delta
	offset_vector = Vector2(cos(angle), sin(angle)) * orbit_radius
	global_position = center_position + offset_vector 
	
	sprite.flip_h = offset_vector.y < 0
