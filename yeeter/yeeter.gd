extends Control

var is_playing = false

# Remaining bar
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

func _ready():
	$end_overlay.hide()
	
func _process(delta):
	# TODO - Get rid of this
	if Input.is_action_just_pressed("ui_up"):
		print("Number of eggs")
		print(get_tree().get_nodes_in_group("eggs").size())

# Transition from start screen to game
func _on_start_overlay_ready_to_start():
	is_playing = true

# Transition from game to end screen
func _on_remaining_none_remaining():
	is_playing = false
	$end_overlay.show()

# Transition from end screen to home screen
func _on_end_overlay_ready_to_end():
	close_game()

func _on_back_button_pressed():
	close_game()

func close_game():
	get_parent().show_main_screen()
	queue_free()
