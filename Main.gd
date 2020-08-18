extends Node

var memory_game
var egg_yeeter_game
var hatch_scene
var flappy_bird
var scene_instance
var current_difficulty = "easy"
var current_act = 1
var current_game_name

var flappy_text = "It's time to fly the nest and find somewhere to settle down.\n\nTap the screen (or the space bar) to fly and avoid the obstacles!"
var memory_text = "This place looks nice. Better build a nest!\n\nClick a card to flip it and reveal something you might want for your nest.\n\nFind all the matching pairs within the time limit to win the game!"
var yeeter_text = "What a lovely nest! Well done. Now time to lay some eggs!\n\nHold space to lay an egg and use the left and right buttons to aim. Release the spacebar to  shoot the egg out, or use the on-screen controls.\n\nGet as many eggs as you can into the nest!"
var main_action_button_func = funcref(self, 'start_game')

func _ready():
	hide_main_screen()
	hide_banner_buttons()
	$Signposts.hide()
	$BackgroundMusic.play()
	flappy_bird = preload("res://flappy-bird/FlappyBirdMain.tscn")
	memory_game = preload("res://memory/MemoryGameMain.tscn")
	egg_yeeter_game = preload("res://yeeter/yeeter.tscn")
	hatch_scene = preload("res://hatching/Hatching.tscn")
	
func hide_banner_buttons():
	$EndOfGameBanners/win_banner.hide()
	$EndOfGameBanners/lose_banner.hide()
	$EndOfGameBanners/finish_banner.hide()

func hide_main_screen():
	$MainTextBox.hide()
	$StartGameButton.hide()

func _on_main_start_game():
	$Signposts.show()
	$BackgroundMusic.stop()
	start_flappy_scene()

func start_scene(start_screen_text, scene, scene_name):
	main_action_button_func = funcref(self, 'start_game')
	current_game_name = scene_name
	hide_banner_buttons()
	$MainTextBox.show()
	$StartGameButton.show()
	$MainTextBox/MainText.text = start_screen_text
	$StartGameButton.text = "PLAY"
	scene_instance = scene.instance()
	scene_instance.difficulty = current_difficulty
	scene_instance.connect("scene_finished", self, "_on_scene_finished")

func setup_signposts(act_num, scene_num):
	$Signposts/Scene.text = "SCENE " + str(scene_num)
	$Signposts/Act.text = "ACT " + str(act_num)

# Running Flappy Bird scene
func start_flappy_scene():
	setup_signposts(current_act, 1)
	start_scene(flappy_text, flappy_bird, "flappy")

# Running Memory scene
func start_memory_scene():
	setup_signposts(current_act, 2)
	start_scene(memory_text, memory_game, "memory")

# Running Yeeter scene
func start_yeeter_scene():
	setup_signposts(current_act, 3)
	start_scene(yeeter_text, egg_yeeter_game, "yeeter")

# Handling start scene button pressed
func _on_start_game_button_pressed():
	main_action_button_func.call_func()

func start_game():
	hide_main_screen()
	add_child(scene_instance)

# Running Hatching scene
func start_hatch_scene():
	hide_main_screen()
	$EggHatchMusic.play()
	current_game_name = "hatch"
	scene_instance = hatch_scene.instance()
	scene_instance.difficulty = current_difficulty
	scene_instance.connect("scene_finished", self, "_on_scene_finished")
	add_child(scene_instance)
	scene_instance.start()

# Handler for when minigames finish
func _on_scene_finished(has_won):
	print(current_game_name + " game finished with this result: " + str(has_won))
	scene_instance.queue_free()
	
	display_end_screen(has_won, current_game_name)

func display_end_screen(has_won, current_game_name):
	hide_banner_buttons()
	
	if current_game_name == 'yeeter' && current_act == 3 && has_won:
		$EndOfGameBanners/finish_banner.show()
		$MainTextBox/MainText.text = "You've finished the game!"
		$MainTextBox.show()
		$StartGameButton.hide()
		return
	elif current_game_name == "hatch":
		$MainTextBox/MainText.text = "You've completed this act!"
		$StartGameButton.text = "NEXT ACT"
		main_action_button_func = funcref(self, 'proceed_to_next_scene')
	elif has_won:
		$EndOfGameBanners/win_banner.show()
		$MainTextBox/MainText.text = "You've completed this level!"
		$StartGameButton.text = "NEXT SCENE"
		main_action_button_func = funcref(self, 'proceed_to_next_scene')
	else:
		$EndOfGameBanners/lose_banner.show()
		$MainTextBox/MainText.text = "You've failed to complete this level!"
		$StartGameButton.text = "RETRY ACT"
		main_action_button_func = funcref(self, 'start_flappy_scene')
	
	$MainTextBox.show()
	$StartGameButton.show()

func proceed_to_next_scene():
	match current_game_name:
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
