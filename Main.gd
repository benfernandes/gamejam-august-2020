extends Node

var memory_game
var egg_yeeter_game
var hatch_scene
var flappy_bird
var scene_instance
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

# Temp
func start_scene(text_node, button_node, scene, scene_name):
	text_node.show()
	button_node.show()
	scene_instance = scene.instance()
	scene_instance.difficulty = current_difficulty
	scene_instance.connect("scene_finished", self, "_on_scene_finished", [scene_name])

# Running Flappy Bird scene
func start_flappy_scene():
	start_scene($FlappyBirdTextBox, $FlappyBirdButton, flappy_bird, "flappy")

# Running Memory scene
func start_memory_scene():
	start_scene($MemoryGameTextBox, $MemoryGameButton, memory_game, "memory")

# Running Yeeter scene
func start_yeeter_scene():
	start_scene($EggYeeterTextBox, $EggYeeterButton, egg_yeeter_game, "yeeter")

# Handling start scene button pressed
func _on_start_scene_button_pressed():
	hide_main_screen()
	add_child(scene_instance)

# Running Hatching scene
func start_hatch_scene():
	hide_main_screen()
	scene_instance = hatch_scene.instance()
	scene_instance.difficulty = current_difficulty
	scene_instance.connect("scene_finished", self, "_on_scene_finished", ["hatch"])
	add_child(scene_instance)
	scene_instance.start()

# Handler for when minigames finish
func _on_scene_finished(has_won, game_name):
	print(game_name + " game finished with this result: " + str(has_won))
	scene_instance.queue_free()
	
	match game_name:
		"flappy":
			start_memory_scene()
		"memory":
			start_yeeter_scene()
		"yeeter":
			proceed_to_next_act()
		"hatch":
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
