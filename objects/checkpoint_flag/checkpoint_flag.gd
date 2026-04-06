extends Area2D

@export var current_level: Level
@export var id: int

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var sparkles: AnimatedSprite2D = $Sparkle

func _ready() -> void:
	sparkles.visible = false
	if not current_level:
		push_warning("Flaga %s nie ma przypisanego poziomu" % global_position)
	
	if Globals.active_checkpoint_id == id:
		sprite.play("is_active")
	else:
		sprite.play("not_active")

func _on_area_entered(_area: Area2D) -> void:
	Globals.can_reset = true
	
	if Globals.active_checkpoint_id == id:
		return
	
	Globals.active_checkpoint_id = id
	Globals.checkpoint_level = current_level.scene_file_path
	Globals.checkpoint_position = global_position
	
	sprite.play("set_active")
	sparkles.visible = true
	sparkles.play("sparkle")

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "set_active":
		sprite.play("is_active")
		sparkles.visible = false
