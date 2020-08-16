extends Control

signal game_finished

var no_eggs_remaining = false
var is_finished = false

# Remaining bar
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

var difficulty = "easy"

func _ready():
	$end_overlay.hide()
	
func _process(delta):
	if !is_finished:
		_try_to_trigger_end_screen()

func _try_to_trigger_end_screen():
	var eggs = get_tree().get_nodes_in_group("eggs")
	for egg in eggs:
		if !egg.sleeping:
			return
	
	if no_eggs_remaining:
		is_finished = true
		$end_overlay/end_message_container/end_message.text = "You scored: " + str(eggs.size())
		emit_signal("game_finished")

# Triggered when the user runs out of eggs
func _on_remaining_none_remaining():
	no_eggs_remaining = true

# Transition from end screen to home screen
func _on_end_overlay_ready_to_end():
	close_game()

func _on_back_button_pressed():
	close_game()

func close_game():
	get_parent().handle_game_won("yeeter")
	queue_free()

func _on_yeeter_game_finished():
	$end_overlay.show()
