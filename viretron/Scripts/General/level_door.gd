extends Area2D

# bookmark (Settings)
# We will type the path to our next level exactly (e.g., "res://Scenes/Levels/Level2.tscn") 
# for now I am doing back to the playground so we can test
@export var next_level_path = "res://Scenes/Levels/playground.tscn"

func _ready():
	# bookmark (Connect Signal)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# bookmark (Check for Player)
	if body.name == "Player":
		change_level()

func change_level():
	# bookmark (Switch Scene)
	get_tree().change_scene_to_file(next_level_path)
