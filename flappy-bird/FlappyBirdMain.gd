extends Node

func _ready():
	pass # Replace with function body.

func new_game():
	$FlappyBird.show()
	$FlappyBird.start()

func game_over():
	get_parent()._show_main_screen()
	queue_free()
