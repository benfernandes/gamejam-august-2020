extends Node

var memory_game
var memory_game_instance
var egg_yeeter_game
var egg_yeeter_game_instance
var flappy_bird
var flappy_bird_instance
var difficulty = "easy"

func _ready():
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")
	# preload other minigames

func _hide_main_screen():
	$MemoryGameButton.hide()
	$EggYeeterButton.hide()
	$FlappyBirdButton.hide()
	# add the other buttons to hide here

func show_main_screen():
	$MemoryGameButton.show()
	$EggYeeterButton.show()
	$FlappyBirdButton.show()
	# add the other buttons to show here

func _on_MemoryGameButton_pressed():
	memory_game_instance = memory_game.instance()
	_hide_main_screen()
	add_child(memory_game_instance)

func _on_EggYeeterButton_pressed():
	egg_yeeter_game_instance = egg_yeeter_game.instance()
	_hide_main_screen()
	add_child(egg_yeeter_game_instance)
	
func _on_FlappyBirdButton_pressed():
	flappy_bird_instance = flappy_bird.instance()
	_hide_main_screen()
	add_child(flappy_bird_instance)
	flappy_bird_instance.difficulty = "easy"

# add functions to play other minigames here
