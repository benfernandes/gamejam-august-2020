extends Node
var difficulty

func _ready():
	print("Flappy bird difficulty: " + difficulty)
	$FlappyBird.show()
	$FlappyBird.start(difficulty)
	$Music.play()

func game_over():
	get_parent().handle_game_won("flappy")
	queue_free()
