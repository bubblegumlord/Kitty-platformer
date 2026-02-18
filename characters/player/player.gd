extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	JUMP,
	FALL,
}

#movement constants
const SPEED: float = 200
const ACCELERATION: float = 400
const DECELERATION: float = 800

# jump constants
const JUMP_HEIGHT: float = 75
const JUMP_TIME_PEAK: float = 0.42
const JUMP_TIME_DESCENT: float = 0.3

var direction_x: float
var direction_sprite: float
var coyote_active: bool

@onready var jump_buffer_timer: Timer = $Timers/JumpBufferTimer
@onready var coyote_timer: Timer = $Timers/CoyoteTimer

@onready var jump_velocity: float = -1 * (JUMP_HEIGHT * 2) / JUMP_TIME_PEAK
@onready var gravity_peak: float = (JUMP_HEIGHT * 2) / (JUMP_TIME_PEAK)**2
@onready var gravity_descent: float = (JUMP_HEIGHT * 2) / (JUMP_TIME_DESCENT)**2

func _physics_process(delta: float) -> void:
	direction_x = Input.get_axis("LEFT", "RIGHT")
	
	if direction_x != 0:
		direction_sprite = direction_x
		# run animation
		velocity.x = set_speed(true, ACCELERATION * delta)
		if not check_turn(velocity.x, direction_x):
			# brake animation
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
	else:
		if is_on_floor():
			# idle animation
			velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION / 4 * delta)
	
	if is_on_floor():
		if coyote_active:
			coyote_timer.stop()
			coyote_active = false
	else:
		if !coyote_active:
			coyote_timer.start()
			coyote_active = true
		
		velocity.y += set_gravity() * delta
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
	
	if Input.is_action_just_released("JUMP"):
		# play fall animation
		velocity.y *= 0.5
	
	if (is_on_floor() or !coyote_timer.is_stopped()) and !jump_buffer_timer.is_stopped():
		# play jump animation
		velocity.y = jump_velocity
		coyote_timer.stop()
		coyote_active = true
	
	move_and_slide()

func set_speed(moving: bool, delta: float) -> float:
	if moving:
		return move_toward(velocity.x, direction_x * SPEED, delta)
	else:
		return move_toward(velocity.x, 0, ACCELERATION * delta)

func check_turn(player_velocity: float, direction: float) -> bool:
	if player_velocity < 0 and direction < 0:
		return true
	elif player_velocity > 0 and direction > 0:
		return true
	else:
		return false

func set_gravity() -> float:
	if velocity.y < 0:
		return gravity_peak
	else:
		return gravity_descent
