extends Node

var memory_game
var memory_game_instance
var egg_yeeter_game
var egg_yeeter_game_instance
var flappy_bird
var flappy_bird_instance
var current_difficulty = "easy"
var current_act = 1

func _ready():
	hide_main_screen()
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")

func hide_main_screen():
	$MemoryGameTextBox.hide()
	$MemoryGameButton.hide()
	$EggYeeterTextBox.hide()
	$EggYeeterButton.hide()
	$FlappyBirdTextBox.hide()
	$FlappyBirdButton.hide()
	$EggHatchTextBox.hide()

func _on_main_start_game():
	start_flappy_bird()

# Running Flappy Bird Game
func start_flappy_bird():
	$FlappyBirdTextBox.show()
	$FlappyBirdButton.show()
	flappy_bird_instance = flappy_bird.instance()
	flappy_bird_instance.difficulty = current_difficulty
	flappy_bird_instance.connect("game_finished", self, "_on_game_finished")

func _on_FlappyBirdButton_pressed():
	hide_main_screen()
	add_child(flappy_bird_instance)

# Running Memory Game
func start_memory_game():
	$MemoryGameTextBox.show()
	$MemoryGameButton.show()
	memory_game_instance = memory_game.instance()
	memory_game_instance.difficulty = current_difficulty
	memory_game_instance.connect("game_finished", self, "_on_game_finished")

func _on_MemoryGameButton_pressed():
	hide_main_screen()
	add_child(memory_game_instance)

# Running Yeeter Game
func start_yeeter_game():
	$EggYeeterTextBox.show()
	$EggYeeterButton.show()
	egg_yeeter_game_instance = egg_yeeter_game.instance()
	egg_yeeter_game_instance.difficulty = current_difficulty
	egg_yeeter_game_instance.connect("game_finished", self, "_on_game_finished")

func _on_EggYeeterButton_pressed():
	hide_main_screen()
	add_child(egg_yeeter_game_instance)

# Handler for when minigames finish
func _on_game_finished(game_name, has_won):
	print(game_name)
	print(has_won)
	
	match game_name:
		"flappy":
			flappy_bird_instance.queue_free()
			start_memory_game()
		"memory":
			memory_game_instance.queue_free()
			start_yeeter_game()
		"yeeter":
			egg_yeeter_game_instance.queue_free()
			start_hatching_cutscene()

# Running Hatching Cutscene
func start_hatching_cutscene():
	$EggHatchTextBox.show()
	proceed_to_next_act()
	
func proceed_to_next_act():
	if current_act == 1:
		current_act = 2
		current_difficulty = "medium"
		print("Setting difficulty to medium")
		start_new_act_with_delay()
		return
	elif current_act == 2:
		current_act = 3
		current_difficulty = "hard"		
		print("Setting difficulty to hard")
		start_new_act_with_delay()
		return
	elif current_act == 3:
		print("finished")
		# TODO: handle game finish
		
func start_new_act_with_delay():
	var next_act_timer = Timer.new()
	next_act_timer.set_wait_time(3)
	next_act_timer.set_one_shot(true)
	self.add_child(next_act_timer)
	next_act_timer.start()
	
	yield(next_act_timer, "timeout")
	start_flappy_bird()
