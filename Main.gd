extends Node

var memory_game
var egg_yeeter_game
var hatch_scene
var flappy_bird
var scene_instance
var current_difficulty = "easy"
var current_act = 1

var flappy_text = "It's time to fly the nest and find somewhere to settle down.\n\nTap space to fly and avoid the obstacles!"
var memory_text = "This place looks nice. Better build a nest!\n\nClick a card to flip it and reveal something you might want for your nest.\n\nFind all the matching pairs within the time limit to win the game!"
var yeeter_text = "What a lovely nest! Well done. Now time to lay some eggs!\n\nHold space to lay an egg and use the left and right buttons to aim. Release the spacebar to  shoot the egg out.\n\nGet as many eggs as you can into the backet!"

func _ready():
	hide_main_screen()
	$Signposts.hide()
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")
	hatch_scene = preload("res://hatching/Hatching.tscn")

func hide_main_screen():
	$MainTextBox.hide()
	$StartGameButton.hide()

func _on_main_start_game():
	$Signposts.show()
	start_flappy_scene()

# Temp
func start_scene(start_screen_text, scene, scene_name):
	$MainTextBox.show()
	$StartGameButton.show()
	$MainTextBox/MainText.text = start_screen_text
	scene_instance = scene.instance()
	scene_instance.difficulty = current_difficulty
	scene_instance.connect("scene_finished", self, "_on_scene_finished", [scene_name])

# Running Flappy Bird scene
func start_flappy_scene():
	$Signposts/Scene.text = "SCENE 1"
	$Signposts/Act.text = "ACT " + str(current_act)
	start_scene(flappy_text, flappy_bird, "flappy")

# Running Memory scene
func start_memory_scene():
	$Signposts/Scene.text = "SCENE 2"
	start_scene(memory_text, memory_game, "memory")

	# Running Yeeter scene
func start_yeeter_scene():
	$Signposts/Scene.text = "SCENE 3"
	start_scene(yeeter_text, egg_yeeter_game, "yeeter")

# Handling start scene button pressed
func _on_start_game_button_pressed():
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
