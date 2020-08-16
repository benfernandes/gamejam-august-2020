extends Control

signal ready_to_end

func _on_end_button_pressed():
	emit_signal("ready_to_end")
