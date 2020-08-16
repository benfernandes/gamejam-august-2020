extends Node

var memory_game
var memory_game_instance
var egg_yeeter_game
var egg_yeeter_game_instance
var hatch_scene
var hatch_scene_instance
var flappy_bird
var flappy_bird_instance
var current_difficulty = "easy"
var current_act = 1

func _ready():
	hide_main_screen()
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")
	hatch_scene = preload("res://hatching/Hatching.tscn")

func hide_main_screen():
	$MemoryGameTextBox.hide()
	$MemoryGameButton.hide()
	$EggYeeterTextBox.hide()
	$EggYeeterButton.hide()
	$FlappyBirdTextBox.hide()
	$FlappyBirdButton.hide()
	
func handle_game_won(game):
	if game == "hatch":
		$FlappyBirdTextBox.show()
		$FlappyBirdButton.show()
		flappy_bird_instance = flappy_bird.instance()
		flappy_bird_instance.difficulty = current_difficulty
	elif game == "flappy":
		$MemoryGameTextBox.show()
		$MemoryGameButton.show()
		memory_game_instance = memory_game.instance()
		memory_game_instance.difficulty = current_difficulty
	elif game == "memory":
		$EggYeeterTextBox.show()
		$EggYeeterButton.show()
		egg_yeeter_game_instance = egg_yeeter_game.instance()
		egg_yeeter_game_instance.difficulty = current_difficulty
	elif game == "yeeter":
		proceed_to_next_act()

func show_main_screen():
	$FlappyBirdTextBox.show()
	$FlappyBirdButton.show()
	flappy_bird_instance = flappy_bird.instance()
	flappy_bird_instance.difficulty = current_difficulty

func _on_MemoryGameButton_pressed():
	hide_main_screen()
	add_child(memory_game_instance)

func _on_EggYeeterButton_pressed():
	hide_main_screen()
	add_child(egg_yeeter_game_instance)
	
func _on_FlappyBirdButton_pressed():
	hide_main_screen()
	add_child(flappy_bird_instance)
	
func proceed_to_next_act():
	if current_act == 1:
		current_act = 2
		current_difficulty = "medium"
		print("Setting difficulty to medium")
		start_new_act()
		return
	elif current_act == 2:
		current_act = 3
		current_difficulty = "hard"		
		print("Setting difficulty to hard")
		start_new_act()
		return
	elif current_act == 3:
		print("finished")
		# TODO: handle game finish
		
func start_new_act():
	hide_main_screen()
	hatch_scene_instance = hatch_scene.instance()
	hatch_scene_instance.difficulty = current_difficulty
	add_child(hatch_scene_instance)
	hatch_scene_instance.start()
