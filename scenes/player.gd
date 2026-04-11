extends CharacterBody2D

const SPEED = 500
const JUMP_VELOCITY = -700
const GRAVITY = 600

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Left/right movement (optional but useful)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()
