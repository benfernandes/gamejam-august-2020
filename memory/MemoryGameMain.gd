extends Node

signal game_finished(game_name, has_won)

var number_of_matches = 0
var max_matches = 7
var game_time
var difficulty

var config
var easy_config = {
	"game_time": 45
}
var medium_config = {
	"game_time": 30
}
var hard_config = {
	"game_time": 25
}

func _ready():
	print("Memory difficulty: " + difficulty)
	match difficulty:
		"easy":
			config = easy_config
		"medium":
			config = medium_config
		"hard": 
			config = hard_config
	
	game_time = config.game_time
	
	randomize()
	$SecondTicker.start()
	$HUD.update_time_left(game_time)
	$Music.play()
	
func add_match():
	number_of_matches += 1
	$PointSound.play()
	$HUD.update_matches(number_of_matches)
	if number_of_matches == max_matches:
		$SecondTicker.stop()
		$Board.show_all_cards()
		$WinSound.play()
		game_over()

func game_over():
	var has_won = number_of_matches == max_matches
	$HUD.display_result(has_won)
	$Music.stop()
	
	var end_timer = Timer.new()
	end_timer.set_wait_time(4)
	end_timer.set_one_shot(true)
	self.add_child(end_timer)
	end_timer.start()
	
	yield(end_timer, "timeout")
	emit_signal("game_finished", "memory", has_won)

func _on_SecondTicker_timeout():
	game_time -= 1
	$HUD.update_time_left(game_time)
	if game_time == 0:
		$Board.disable_card_clicks()
		$SecondTicker.stop()
		$LoseSound.play()
		game_over()
	
