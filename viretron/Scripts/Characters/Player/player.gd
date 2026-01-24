extends CharacterBody2D

# bookmark (Movement Settings)
@export var walk_speed = 150.0
@export var run_speed = 250.0
@export var jump_velocity = -500.0
@export var gravity = 900.0
var is_running = false

# bookmark (Health Settings)
@export var max_health = 100
var current_health = 100

# bookmark (Node References)

@onready var visuals = $ColorRect
@onready var health_bar = $HUD/HealthBar

func _ready():
	# bookmark (Initialize Health)
	current_health = max_health
	if health_bar:
		health_bar.max_value = max_health
		health_bar.value = current_health
	
	# --- NEW FIX: AUTO-CENTER THE COLOR RECT ---
	
	if visuals:
		visuals.pivot_offset = visuals.size / 2
		visuals.position = -visuals.size / 2
	# -------------------------------------------

func _physics_process(delta):
	# bookmark (Apply Gravity)
	if not is_on_floor():
		velocity.y += gravity * delta

	# bookmark (Handle Jump)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# bookmark (Handle Movement Input)
	var direction = Input.get_axis("move_left", "move_right")

	# bookmark (Check Run State)
	if Input.is_action_pressed("run"):
		is_running = true
	else:
		is_running = false

	# bookmark (Determine Speed)
	var current_speed = run_speed if is_running else walk_speed

	# bookmark (Move and Face Direction)
	if direction:
		velocity.x = direction * current_speed
		
		# Flip the ColorRect (Visuals)

		if visuals:
			if direction > 0:
				visuals.scale.x = 1
			elif direction < 0:
				visuals.scale.x = -1
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()

func _input(event):
	# bookmark (Test Damage Key)
	if event is InputEventKey and event.pressed and event.keycode == KEY_T:
		if not event.echo:
			take_damage(10)

func take_damage(amount):
	# bookmark (Damage Logic)
	current_health -= amount
	
	if current_health < 0:
		current_health = 0
	
	if health_bar:
		health_bar.value = current_health
		
	print("Ouch! Health is now: ", current_health)
	
	if current_health == 0:
		die()

func die():
	# bookmark (Death Logic)
	print("Player has died!")
	get_tree().reload_current_scene()
