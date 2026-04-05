extends Camera2D

@onready var top_left: Marker2D = $TopLeft
@onready var bot_right: Marker2D = $BotRight

func _ready() -> void:
	limit_left = int(top_left.global_position.x)
	limit_right = int(bot_right.global_position.x)
	limit_top = int(top_left.global_position.y)
	limit_bottom = int(bot_right.global_position.y)
