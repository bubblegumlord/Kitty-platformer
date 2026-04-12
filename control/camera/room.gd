extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	print(global_position)
	Globals.UPDATE_CAMERA.emit(global_position)
