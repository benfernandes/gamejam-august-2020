extends Node

func _ready():
	randomize()

func new_game():
	$Board.show()
	$Board.start()
