extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	JUMP,
	FALL,
}

@export var speed: int = 200
@export var jump_speed: int = -400

func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed
	
	if not is_on_floor():
		velocity.y += Globals.GRAVITY * delta
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_speed
	
	move_and_slide()
