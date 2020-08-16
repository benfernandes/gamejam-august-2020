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
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")

func hide_main_screen():
	$MemoryGameTextBox.hide()
	$MemoryGameButton.hide()
	$EggYeeterTextBox.hide()
	$EggYeeterButton.hide()
	$FlappyBirdTextBox.hide()
	$FlappyBirdButton.hide()
	$EggHatchTextBox.hide()
	
func handle_game_won(game):
	if game == "memory":
		$EggYeeterTextBox.show()
		$EggYeeterButton.show()
		egg_yeeter_game_instance = egg_yeeter_game.instance()
		egg_yeeter_game_instance.difficulty = current_difficulty
	elif game == "yeeter":
		$EggHatchTextBox.show()
		proceed_to_next_act()
	elif game == "hatch":
		$FlappyBirdTextBox.show()
		$FlappyBirdButton.show()
		flappy_bird_instance = flappy_bird.instance()
		flappy_bird_instance.difficulty = current_difficulty	
	elif game == "flappy":
		$MemoryGameTextBox.show()
		$MemoryGameButton.show()
		memory_game_instance = memory_game.instance()
		memory_game_instance.difficulty = current_difficulty
		
func show_main_screen():
	$FlappyBirdTextBox.show()
	$FlappyBirdButton.show()
	flappy_bird_instance = flappy_bird.instance()

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
	handle_game_won("hatch")
