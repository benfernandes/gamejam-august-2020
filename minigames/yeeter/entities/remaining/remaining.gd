extends Control

# Remaining bar
export (NodePath) var remaining_bar_path
onready var remaining_bar = get_node(remaining_bar_path)

func decrement_value():
	remaining_bar.decrement_value()
	
func get_value():
	return remaining_bar.value
