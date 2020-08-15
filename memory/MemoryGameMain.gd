extends Node

var number_of_matches
var max_matches
var game_time

func _ready():
	number_of_matches = 0
	max_matches = 7
	game_time = 30
	randomize()

func new_game():
	$Board.show()
	$Board.start()
	$SecondTicker.start()
	
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
	get_parent()._show_main_screen()
	queue_free()

func _on_SecondTicker_timeout():
	game_time -= 1
	$HUD.update_time_left(game_time)
	if game_time == 0:
		$Board.disable_card_clicks()
		$SecondTicker.stop()
		game_over()
	
