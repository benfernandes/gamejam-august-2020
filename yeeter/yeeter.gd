extends Control

signal scene_finished(has_won)

var no_eggs_remaining = false
var is_finished = false
var difficulty
var target_eggs

# Configurations
var config
var easy_config = {
	"target_eggs": 3
}
var medium_config = {
	"target_eggs": 5
}
var hard_config = {
	"target_eggs": 7
}

# Remaining bar
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)
onready var fire_button = $Fire

func _ready():
	print("Yeeter difficulty: " + difficulty)
	match difficulty:
		"easy":
			config = easy_config
		"medium":
			config = medium_config
		"hard": 
			config = hard_config
	bird_cannon.set_difficulty(difficulty)
	$Goal.text = "Goal: " + str(config.target_eggs) + " Eggs"
	
	target_eggs = config.target_eggs
	$Music.play()

	
func _process(delta):
	if !is_finished:
		if $Left.pressed:
			bird_cannon.rotation_degrees -= 1
		if $Right.pressed:
			bird_cannon.rotation_degrees += 1
		_try_to_trigger_end_screen()

func _try_to_trigger_end_screen():
	var eggs = get_tree().get_nodes_in_group("eggs")
	for egg in eggs:
		if !egg.sleeping:
			return
	
	if no_eggs_remaining:
		$Music.stop()
		var won = eggs.size() >= target_eggs
		if won:
			$WinSound.play()
		else:
			$LoseSound.play()
		emit_signal("scene_finished", won)

# Triggered when the user runs out of eggs
func _on_remaining_none_remaining():
	no_eggs_remaining = true
