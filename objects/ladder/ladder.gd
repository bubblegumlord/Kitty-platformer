extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.can_climb = true

func _on_body_exited(body: Node2D) -> void:
	body.can_climb = true
	body.State = body.State.FALL
