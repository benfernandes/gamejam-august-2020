extends Node

var number_of_matches = 0
var max_matches = 7
var game_time
var difficulty = "easy"

func _ready():
	match difficulty:
		"easy":
			game_time = 45
		"medium":
			game_time = 30
		"hard": 
			game_time = 25
	randomize()
	$SecondTicker.start()
	$HUD.update_time_left(game_time)
	
func add_match():
	number_of_matches += 1
	$HUD.update_matches(number_of_matches)
	if number_of_matches == max_matches:
		$SecondTicker.stop()
		$Board.show_all_cards()
		game_over()

func game_over():
	$HUD.display_result(number_of_matches == max_matches)
	
	var end_timer = Timer.new()
	end_timer.set_wait_time(4)
	end_timer.set_one_shot(true)
	self.add_child(end_timer)
	end_timer.start()
	
	yield(end_timer, "timeout")
	close_game()

func _on_SecondTicker_timeout():
	game_time -= 1
	$HUD.update_time_left(game_time)
	if game_time == 0:
		$Board.disable_card_clicks()
		$SecondTicker.stop()
		game_over()
	
func _on_Button_pressed():
	close_game()
	
func close_game():
	get_parent().handle_game_won("memory")
	queue_free()
