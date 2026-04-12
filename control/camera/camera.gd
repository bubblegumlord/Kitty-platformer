extends Camera2D

const ROOM_WIDTH: int = 320
const ROOM_HEIGHT: int = 180
const TIMER: float = 0.15

var new_camera_position: Array[int] = [0, 0, 0, 0]
var change_position: Tween

func _ready() -> void:
	Globals.UPDATE_CAMERA.connect(update_position)

func update_position(camera_position: Vector2) -> void:
	new_camera_position[0] = int(camera_position.x)
	new_camera_position[1] = int(camera_position.x) + ROOM_WIDTH
	new_camera_position[2] = int(camera_position.y)
	new_camera_position[3] = int(camera_position.y) + ROOM_HEIGHT
	
	print(new_camera_position)
	
	change_position = get_tree().create_tween().set_parallel()
	
	change_position.tween_property(self, "limit_left", new_camera_position[0], TIMER)
	change_position.tween_property(self, "limit_right", new_camera_position[1], TIMER)
	change_position.tween_property(self, "limit_top", new_camera_position[2], TIMER)
	change_position.tween_property(self, "limit_bottom", new_camera_position[3], TIMER)
	
