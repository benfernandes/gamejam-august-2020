extends Node

var difficulty = "easy"

func _ready():
	pass # Replace with function body.

func new_game():
	$FlappyBird.show()
	$FlappyBird.start(difficulty)

func game_over():
	get_parent().show_main_screen()
	queue_free()
