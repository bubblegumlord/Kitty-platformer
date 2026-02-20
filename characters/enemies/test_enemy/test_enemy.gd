extends CharacterBody2D

@export var player: Player

func _ready() -> void:
	if not player:
		print("Przeciwnik " + str(global_position) + " brak przypisanego Gracza")

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if player.state == player.State.FALL:
		# only testing
		queue_free()
		player.velocity.y = - 500
	else:
		player.is_hit = true
		player.state = player.State.HIT
