extends Node

func _ready():
	randomize()

func new_game():
	$Board.show()
	$Board.start()

func game_over():
	get_parent()._show_main_screen()
	queue_free()
