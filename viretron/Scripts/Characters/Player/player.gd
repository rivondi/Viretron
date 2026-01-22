extends CharacterBody2D

# bookmark (1) Player Movement Variables
@export var walk_speed = 150.0
@export var run_speed = 250.0
@export var jump_velocity = -350.0
@export var gravity = 900.0

# bookmark (2) State Machine Setup
enum State { IDLE, RUN, JUMP, FALL }
var current_state = State.IDLE

# bookmark (3) Visual References
@onready var visual_root = $ColorRect

func _physics_process(delta):
	# bookmark (4) Global Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# bookmark (5) Input Processing
	var direction = Input.get_axis("move_left", "move_right")
	var want_jump = Input.is_action_just_pressed("jump")
	var want_run = Input.is_action_pressed("run")
	
	# bookmark (6) State Transition Logic
	if is_on_floor():
		if want_jump:
			current_state = State.JUMP
			velocity.y = jump_velocity
		elif direction != 0:
			current_state = State.RUN
		else:
			current_state = State.IDLE
	else:
		if velocity.y > 0:
			current_state = State.FALL

	# bookmark (7) State Behavior & Movement
	var current_speed = run_speed if want_run else walk_speed
	
	if direction:
		velocity.x = direction * current_speed
		flip_character(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()

# bookmark (8) Flip Logic
func flip_character(direction_input):
	if direction_input < 0:
		transform.x.x = -1 
	elif direction_input > 0:
		transform.x.x = 1
