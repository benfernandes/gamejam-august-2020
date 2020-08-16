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

func _on_main_start_game():
	start_flappy_scene()

# Running Flappy Bird scene
func start_flappy_scene():
	$FlappyBirdTextBox.show()
	$FlappyBirdButton.show()
	flappy_bird_instance = flappy_bird.instance()
	flappy_bird_instance.difficulty = current_difficulty
	flappy_bird_instance.connect("scene_finished", self, "_on_scene_finished")

func _on_FlappyBirdButton_pressed():
	hide_main_screen()
	add_child(flappy_bird_instance)

# Running Memory scene
func start_memory_scene():
	$MemoryGameTextBox.show()
	$MemoryGameButton.show()
	memory_game_instance = memory_game.instance()
	memory_game_instance.difficulty = current_difficulty
	memory_game_instance.connect("scene_finished", self, "_on_scene_finished")

func _on_MemoryGameButton_pressed():
	hide_main_screen()
	add_child(memory_game_instance)

# Running Yeeter scene
func start_yeeter_scene():
	$EggYeeterTextBox.show()
	$EggYeeterButton.show()
	egg_yeeter_game_instance = egg_yeeter_game.instance()
	egg_yeeter_game_instance.difficulty = current_difficulty
	egg_yeeter_game_instance.connect("scene_finished", self, "_on_scene_finished")

func _on_EggYeeterButton_pressed():
	hide_main_screen()
	add_child(egg_yeeter_game_instance)

# Running Hatching scene
func start_hatch_scene():
	hide_main_screen()
	hatch_scene_instance = hatch_scene.instance()
	hatch_scene_instance.difficulty = current_difficulty
	hatch_scene_instance.connect("scene_finished", self, "_on_scene_finished")
	add_child(hatch_scene_instance)
	hatch_scene_instance.start()

# Handler for when minigames finish
func _on_scene_finished(game_name, has_won):
	print(game_name + " game finished with this result: " + str(has_won))
	
	match game_name:
		"flappy":
			flappy_bird_instance.queue_free()
			start_memory_scene()
		"memory":
			memory_game_instance.queue_free()
			start_yeeter_scene()
		"yeeter":
			egg_yeeter_game_instance.queue_free()
			proceed_to_next_act()
		"hatch":
			hatch_scene_instance.queue_free()
			start_flappy_scene()

func proceed_to_next_act():
	if current_act == 1:
		current_act = 2
		current_difficulty = "medium"
		print("Setting difficulty to medium")
		start_hatch_scene()
		return
	elif current_act == 2:
		current_act = 3
		current_difficulty = "hard"		
		print("Setting difficulty to hard")
		start_hatch_scene()
		return
	elif current_act == 3:
		print("finished")
		# TODO: handle game finish
