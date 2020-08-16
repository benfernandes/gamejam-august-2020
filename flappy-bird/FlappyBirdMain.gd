extends Node

signal scene_finished(has_won)

var difficulty

func _ready():
	print("Flappy bird difficulty: " + difficulty)
	$FlappyBird.show()
	$FlappyBird.start(difficulty)
	$Music.play()

func game_over(has_won):
	emit_signal("scene_finished", has_won)
