extends Node
var difficulty = "easy"

func _ready():
	$FlappyBird.show()
	$FlappyBird.start()

func game_over():
	get_parent().handle_game_won("flappy")
	queue_free()
