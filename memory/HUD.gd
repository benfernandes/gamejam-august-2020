extends CanvasLayer

var matches_found_template
var time_left_template

func _ready():
	$ResultsContainer.hide()
	matches_found_template = "Matches found: %s"
	time_left_template = "Time left: %s"

func update_matches(number_of_matches):
	var matches_found_string = matches_found_template % str(number_of_matches)
	$MatchesFoundLabel.text = matches_found_string

func update_time_left(time):
	var time_left_string = time_left_template % str(time)
	$TimeLeftLabel.text = time_left_string
	
func display_result(win):
	$ResultsContainer.show()
	$ResultsContainer.get_node("Results").text = "You won! :)" if win else "You lost :("
