extends Area2D

@export var current_level: Node2D

func _ready() -> void:
	if not current_level:
		print("Flaga " + str(global_position) + " brak przypisanego poziomu")

func _on_area_entered(_area: Area2D) -> void:
	if Globals.checkpoint_level != current_level:
		Globals.checkpoint_level = current_level
	
	if Globals.active_checkpoint != global_position:
		Globals.active_checkpoint = global_position
