extends Control

signal game_finished(game_name, has_won)

var no_eggs_remaining = false
var is_finished = false
var difficulty
var target_eggs

# Configurations
var config
var easy_config = {
	"target_eggs": 5
}
var medium_config = {
	"target_eggs": 7
}
var hard_config = {
	"target_eggs": 10
}

# Remaining bar
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

func _ready():
	print("Yeeter difficulty: " + difficulty)
	$end_overlay.hide()
	match difficulty:
		"easy":
			config = easy_config
		"medium":
			config = medium_config
		"hard": 
			config = hard_config
	
	target_eggs = config.target_eggs

	
func _process(delta):
	if !is_finished:
		_try_to_trigger_end_screen()

func _try_to_trigger_end_screen():
	var eggs = get_tree().get_nodes_in_group("eggs")
	for egg in eggs:
		if !egg.sleeping:
			return
	
	if no_eggs_remaining:
		emit_signal("game_finished", "yeeter", true)
		#is_finished = true
		#$end_overlay/end_message_container/end_message.text = "You scored: " + str(eggs.size()) + "/" + str(target_eggs)

# Triggered when the user runs out of eggs
func _on_remaining_none_remaining():
	no_eggs_remaining = true

# Transition from end screen to home screen
func _on_end_overlay_ready_to_end():
	var eggs = get_tree().get_nodes_in_group("eggs")
	var game_won = eggs.size() >= target_eggs
	emit_signal("game_finished", "yeeter", game_won)

func _on_yeeter_game_finished():
	$end_overlay.show()
