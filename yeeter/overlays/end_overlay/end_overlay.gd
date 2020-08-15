extends Control

signal ready_to_end

func _ready():
	$score.text = "You scored: " + str(get_tree().get_nodes_in_group("eggs").size())

func _on_end_button_pressed():
	emit_signal("ready_to_end")
