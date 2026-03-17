extends CharacterBody2D
class_name Player

enum State {
	IDLE,
	MOVE,
	JUMP,
	FALL,
	HIT
}

# movement constants
const SPEED: float = 160
const ACCELERATION: float = 480
const DECELERATION: float = 800

# jump constants
const JUMP_HEIGHT: float = 60
const JUMP_TIME_PEAK: float = 0.35
const JUMP_TIME_DESCENT: float = 0.25

var direction_x: float
var direction_sprite: float = 1
var coyote_active: bool = false
var is_hit: bool = false

var state: State = State.IDLE

@onready var sprite: Node2D = $Visuals/Sprite
@onready var animation_player: AnimationPlayer = $Visuals/AnimationPlayer
@onready var jump_buffer_timer: Timer = $Timers/JumpBufferTimer
@onready var coyote_timer: Timer = $Timers/CoyoteTimer

@onready var jump_velocity: float = -1 * (JUMP_HEIGHT * 2) / JUMP_TIME_PEAK
@onready var gravity_peak: float = (JUMP_HEIGHT * 2) / (JUMP_TIME_PEAK)**2
@onready var gravity_descent: float = (JUMP_HEIGHT * 2) / (JUMP_TIME_DESCENT)**2

func _ready() -> void:
	Globals.RESET_OBJECTS.connect(on_reset)

func _physics_process(delta: float) -> void:
	direction_x = Input.get_axis("LEFT", "RIGHT")
	flip_sprite()
	
	match state:
		State.IDLE:
			idle_state()
		State.MOVE:
			move_state(delta)
		State.JUMP:
			jump_state(delta)
		State.FALL:
			fall_state(delta)
		State.HIT:
			hit_state()
	
	velocity.y += set_gravity() * delta
	check_coyote()
	move_and_slide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RESET"):
		Globals.RESET_LEVEL.emit()

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	is_hit = true
	state = State.HIT

## STATE MACHINE
func idle_state() -> void:
	animation_player.play("idle")
	if direction_x != 0 and is_on_floor():
		state = State.MOVE
		return
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
		state = State.JUMP
		return
	
	if not is_on_floor() and velocity.y > 0:
		state = State.FALL

func move_state(delta: float) -> void:
	if check_turn(velocity.x, direction_sprite):
		animation_player.play("run")
	else:
		animation_player.play("brake")
		sprite.flip_h = !sprite.flip_h
	
	if direction_x != 0:
		direction_sprite = direction_x
		velocity.x = set_speed(true, ACCELERATION * delta)
	else:
		velocity.x = set_speed(false, DECELERATION * delta)
	
	if direction_x == 0 and velocity.x == 0 and is_on_floor():
		state = State.IDLE
		return
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
		state = State.JUMP
		return
	
	if not is_on_floor() and velocity.y > 0:
		state = State.FALL

func jump_state(delta: float) -> void:
	animation_player.play("jump")
	if direction_x != 0:
		velocity.x = set_speed(true, ACCELERATION * delta)
	else:
		velocity.x = set_speed(false, 0.1 * DECELERATION * delta)
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
	
	if (is_on_floor() or !coyote_timer.is_stopped()) and !jump_buffer_timer.is_stopped():
		velocity.y = jump_velocity
		jump_buffer_timer.stop()
		coyote_timer.stop()
		coyote_active = true
	
	if velocity.y > 0:
		state = State.FALL

func fall_state(delta: float) -> void:
	animation_player.play("fall")
	if direction_x != 0:
		velocity.x = set_speed(true, ACCELERATION * delta)
	else:
		velocity.x = set_speed(false, 0.1 * DECELERATION * delta)
	
	if Input.is_action_just_pressed("JUMP"):
		jump_buffer_timer.start()
	
	if not jump_buffer_timer.is_stopped():
		if is_on_floor() or not coyote_timer.is_stopped():
			state = State.JUMP
			return
	
	if is_on_floor():
		if direction_x == 0 and velocity.x == 0:
			state = State.IDLE
		else:
			state = State.MOVE

func hit_state() -> void:
	animation_player.play("hit")
	if is_on_floor() and not is_hit:
		state = State.MOVE
	
	if is_hit:
		velocity.x = -1 * direction_sprite * SPEED
		velocity.y = jump_velocity
		is_hit = false

## HELPER FUNCTIONS
func flip_sprite() -> void:
	if direction_sprite > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func set_speed(moving: bool, delta: float) -> float:
	if moving:
		return move_toward(velocity.x, direction_x * SPEED, delta)
	else:
		return move_toward(velocity.x, 0, delta)

func set_gravity() -> float:
	if velocity.y < 0:
		return gravity_peak
	else:
		return gravity_descent

func check_turn(player_velocity: float, direction: float) -> bool:
	if player_velocity * direction >= 0:
		return true
	else:
		return false

func check_coyote() -> void:
	if is_on_floor():
		if coyote_active:
			coyote_timer.stop()
			coyote_active = false
	else:
		if !coyote_active:
			coyote_timer.start()
			coyote_active = true

func on_reset() -> void:
	global_position = Globals.checkpoint_position
	velocity = Vector2.ZERO
	state = State.IDLE
