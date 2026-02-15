extends Area2D

@export var id: int

func _ready() -> void:
	if id == 0:
		print("Ryba " + str(global_position) + " niewłaściwe ID")

func _on_area_entered(_area: Area2D) -> void:
	Globals.items[id] = true
	queue_free()
