extends CanvasLayer

var matches_found_template
var time_left_template

signal start_game

func _ready():
	$MatchesFoundLabel.hide()
	$TimeLeftLabel.hide()
	matches_found_template = "Matches found: %s"
	time_left_template = "Time left: %s"

func _on_StartButton_pressed():
	$StartButton.hide()
	$Instructions.hide()
	$MatchesFoundLabel.show()
	$TimeLeftLabel.show()
	emit_signal("start_game")

func update_matches(number_of_matches):
	var matches_found_string = matches_found_template % str(number_of_matches)
	$MatchesFoundLabel.text = matches_found_string

func update_matches_color():
	$MatchesFoundLabel.add_color_override("font_color", Color(0,1,0))
	
func update_time_left(time):
	var time_left_string = time_left_template % str(time)
	$TimeLeftLabel.text = time_left_string
	
func display_result(win):
	$ResultsLabel.text = "You won! :)" if win else "You lost :("
