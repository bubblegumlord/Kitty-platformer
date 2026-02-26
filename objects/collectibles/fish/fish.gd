extends Area2D

@export var id: int = 0

func _ready() -> void:
	if id == 0:
		push_warning("Ryba %s niewłaściwe ID" % global_position)
	
	if Globals.items[id] == true:
		queue_free()

func _on_area_entered(_area: Area2D) -> void:
	Globals.items[id] = true
	queue_free()
