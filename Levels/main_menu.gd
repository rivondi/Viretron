extends Control

# bookmark (1) Node References
# Make sure the names here continue to match our scene tree through any edits
@onready var credits_panel = $CreditsPanel
@onready var start_button = $VBoxContainer/StartButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var close_button = $CreditsPanel/CloseButton

func _ready():
	# bookmark (2) Connect Buttons
	start_button.pressed.connect(_on_start_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	close_button.pressed.connect(_on_close_pressed)

# bookmark (3) Start Game Logic
func _on_start_pressed():
	# Change to the actual game level
	get_tree().change_scene_to_file("res://Viletron git/Viretron/Levels/afghan_hound.tscn")

# bookmark (4) Show Credits
func _on_credits_pressed():
	# Reveal the text box
	credits_panel.visible = true
	# Optional: Hide main buttons so they can't be clicked by accident
	start_button.visible = false
	credits_button.visible = false

# bookmark (5) Hide Credits
func _on_close_pressed():
	# Hide the text box
	credits_panel.visible = false
	# Bring main buttons back
	start_button.visible = true
	credits_button.visible = true
