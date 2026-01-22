extends CanvasLayer

# --- NODE REFERENCES ---
# These must match your Scene Tree names exactly.
@onready var resume_button = $VBoxContainer/ResumeButton
@onready var title_button = $VBoxContainer/TitleButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var credits_panel = $CreditsPanel
@onready var close_credits_button = $CreditsPanel/CloseCreditsButton

func _ready():
	# This connects the clicks to the functions code-side.
	# You do NOT need to use the "Node" tab in the editor.
	resume_button.pressed.connect(_on_resume_pressed)
	title_button.pressed.connect(_on_title_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	close_credits_button.pressed.connect(_on_close_credits_pressed)
	
	# Ensure menu is hidden at start
	visible = false

func _input(event):
	# "ui_cancel" is the Escape key by default
	if event.is_action_pressed("ui_cancel"):
		if credits_panel.visible:
			_on_close_credits_pressed() # Close credits if open
		else:
			toggle_pause() # Toggle the menu

func toggle_pause():
	# Flip the paused state
	get_tree().paused = not get_tree().paused
	# Show menu if paused, hide if unpaused
	visible = get_tree().paused

# --- BUTTON FUNCTIONS ---

func _on_resume_pressed():
	toggle_pause()

func _on_title_pressed():
	# CRITICAL: Unpause before leaving, or the Main Menu will be frozen.
	get_tree().paused = false
	
	# UPDATE THIS PATH if your main menu is in a different folder!
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	credits_panel.visible = true
	$VBoxContainer.visible = false # Hide buttons to clear view

func _on_close_credits_pressed():
	credits_panel.visible = false
	$VBoxContainer.visible = true # Bring buttons back
