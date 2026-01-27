extends Area2D

# bookmark (Settings)
@export_file("*.tscn") var next_level_path

# bookmark (Node References)
@onready var exit_panel = $CanvasLayer/ExitPanel
@onready var yes_button = $CanvasLayer/ExitPanel/YesButton
@onready var no_button = $CanvasLayer/ExitPanel/NoButton
@onready var cooldown_timer = $CooldownTimer

func _ready():
	# bookmark (Initial Setup)
	if exit_panel:
		exit_panel.hide()
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if yes_button:
		yes_button.pressed.connect(_on_yes_pressed)
	if no_button:
		no_button.pressed.connect(_on_no_pressed)

func _on_body_entered(body):
	# bookmark (Trigger UI with Cooldown Check)
	if body.name == "Player":
		# Only show if we have a path AND the timer is finished
		if next_level_path and cooldown_timer.is_stopped():
			exit_panel.show()

func _on_body_exited(body):
	# bookmark (Auto-Close UI)
	if body.name == "Player":
		exit_panel.hide()

func _on_yes_pressed():
	# bookmark (Load Next Level)
	if next_level_path:
		get_tree().change_scene_to_file(next_level_path)

func _on_no_pressed():
	# bookmark (Dismiss UI and Start Cooldown)
	exit_panel.hide()
	cooldown_timer.start()
