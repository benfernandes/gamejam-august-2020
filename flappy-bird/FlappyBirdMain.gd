extends Node

signal game_finished(game_name, has_won)

var difficulty

func _ready():
	print("Flappy bird difficulty: " + difficulty)
	$FlappyBird.show()
	$FlappyBird.start(difficulty)
	$Music.play()

func game_over(has_won):
	emit_signal("game_finished", "flappy", has_won)
