extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	JUMP,
	FALL,
}

const GRAVITY: int = 400

#movement constants
const SPEED: int = 300
const ACCELERATION: int = 600
const DECELERATION: int = 1200
const JUMP_HEIGHT: int = -200

var direction_x: float
var coyote_active: bool

@onready var jump_buffer_timer: Timer = $Timers/JumpBufferTimer
@onready var coyote_timer: Timer = $Timers/CoyoteTimer

func _physics_process(delta: float) -> void:
	direction_x = Input.get_axis("LEFT", "RIGHT")
	
	if direction_x != 0:
		velocity.x = move_toward(velocity.x, direction_x * SPEED, delta * ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, delta * DECELERATION)
	
	if is_on_floor():
		if coyote_active:
			coyote_timer.stop()
			coyote_active = false
	else:
		if !coyote_active:
			coyote_timer.start()
			coyote_active = true
		
		if velocity.y > 10:
			velocity.y += GRAVITY * delta * 2
		else:
			velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
	
	if (is_on_floor() or !coyote_timer.is_stopped()) and !jump_buffer_timer.is_stopped():
		velocity.y = JUMP_HEIGHT
		coyote_timer.stop()
		coyote_active = true
	
	move_and_slide()
