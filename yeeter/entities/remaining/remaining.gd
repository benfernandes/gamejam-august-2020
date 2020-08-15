extends Control

signal none_remaining

# Remaining bar
export (NodePath) var remaining_bar_path
onready var remaining_bar = get_node(remaining_bar_path)

func decrement_value():
	remaining_bar.decrement_value()
	
func get_value():
	return remaining_bar.value

func _on_remaining_bar_value_changed(value):
	if value <= 0:
		emit_signal("none_remaining")
