extends Node

var memory_game
var memory_game_instance

func _ready():
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	memory_game_instance = memory_game.instance()
	# instantiate other minigames
	
func _on_MemoryGameButton_pressed():
	_hide_main_screen()
	add_child(memory_game_instance)
	
# add functions to play other minigames here
	
func _hide_main_screen():
	$MemoryGameButton.hide()
	# add the other buttons to hide here
	
func _show_main_screen():
	$MemoryGameButton.show()
	memory_game_instance = memory_game.instance()
	# add the other buttons to show here and reinstantiate the game
	
