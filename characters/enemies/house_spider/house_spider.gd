extends Area2D

const MIN_MOVE_RANGE: int = 64
const MAX_MOVE_RANGE: int = 96
const NET_BASE_OFFSET: int = -24

var retract: bool = false
var move: Tween
var spider_offset: float

@onready var net_sprite: Sprite2D = $Net
@onready var net_rect: Rect2 = net_sprite.region_rect

func _on_move_timer_timeout() -> void:
	if not retract:
		retract = true
		spider_offset = randi_range(MIN_MOVE_RANGE, MAX_MOVE_RANGE)
		net_rect.size.y += spider_offset
		
		move = get_tree().create_tween().set_parallel()
		
		move.set_trans(Tween.TRANS_SINE)
		move.set_ease(Tween.EASE_IN_OUT)
		
		move.tween_property(self, "position", position + Vector2(0, spider_offset), 0.6)
		move.tween_property(net_sprite, "region_rect", net_rect, 0.6)
		move.tween_property(net_sprite, "position", Vector2(0, NET_BASE_OFFSET - (spider_offset/2)), 0.6)
	else:
		retract = false
		net_rect.size.y -= spider_offset
		
		move = get_tree().create_tween().set_parallel()
		
		move.set_trans(Tween.TRANS_SINE)
		move.set_ease(Tween.EASE_IN_OUT)
		
		move.tween_property(self, "position", position - Vector2(0, spider_offset), 0.4)
		move.tween_property(net_sprite, "region_rect", net_rect, 0.4)
		move.tween_property(net_sprite, "position", Vector2(0, NET_BASE_OFFSET), 0.4)
