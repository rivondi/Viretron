extends CanvasLayer

### bookmark (1) Node References
@onready var resume_button = $VBoxContainer/ResumeButton
@onready var title_button = $VBoxContainer/TitleButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var credits_panel = $CreditsPanel
@onready var close_credits_button = $CreditsPanel/CloseCreditsButton

func _ready():
    # bookmark (2) Connect Signals
    resume_button.pressed.connect(_on_resume_pressed)
    title_button.pressed.connect(_on_title_pressed)
    credits_button.pressed.connect(_on_credits_pressed)
    quit_button.pressed.connect(_on_quit_pressed)
    close_credits_button.pressed.connect(_on_close_credits_pressed)

func _input(event):
    # bookmark (3) Toggle Pause Input
    # "ui_cancel" (Escape key).
    if event.is_action_pressed("ui_cancel"):
        if credits_panel.visible:
            _on_close_credits_pressed() # If credits are open, close them first
        else:
            toggle_pause()

### bookmark (4) Pause Logic
func toggle_pause():
    # Flip the paused state.
    get_tree().paused = not get_tree().paused
    # Show or hide this menu.
    visible = get_tree().paused

### bookmark (5) Button Functions
func _on_resume_pressed():
    toggle_pause()

func _on_title_pressed():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

func _on_quit_pressed():
    get_tree().quit()

### bookmark (6) Credits Logic (Same as Main Menu)
func _on_credits_pressed():
    credits_panel.visible = true
    $VBoxContainer.visible = false

func _on_close_credits_pressed():
    credits_panel.visible = false
    $VBoxContainer.visible = true