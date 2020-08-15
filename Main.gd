extends Node

var memory_game
var memory_game_instance
var egg_yeeter_game
var egg_yeeter_game_instance

func _ready():
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	memory_game_instance = memory_game.instance()
	
	egg_yeeter_game = preload("res://minigames/yeeter/yeeter.tscn")
	egg_yeeter_game_instance = egg_yeeter_game.instance()
	# instantiate other minigames

func _hide_main_screen():
	$MemoryGameButton.hide()
	$EggYeeterButton.hide()
	# add the other buttons to hide here

func _show_main_screen():
	$MemoryGameButton.show()
	$EggYeeterButton.show()
	memory_game_instance = memory_game.instance()
	egg_yeeter_game_instance = egg_yeeter_game.instance()
	# add the other buttons to show here and reinstantiate the game

func _on_MemoryGameButton_pressed():
	_hide_main_screen()
	add_child(memory_game_instance)

func _on_EggYeeterButton_pressed():
	_hide_main_screen()
	add_child(egg_yeeter_game_instance)

# add functions to play other minigames here
