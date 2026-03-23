extends Area2D

const TILE_SIZE: int = 16

@export var length: int = 1

@onready var collision: CollisionShape2D = $Collision
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.region_rect = Rect2(0, 0, TILE_SIZE, TILE_SIZE * length)
	collision.shape.size = Vector2(2, TILE_SIZE * length)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.can_climb = true
		if body.velocity.y != 0 or body.direction_y != 0:
			body.state = body.State.CLIMB

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.can_climb = false
