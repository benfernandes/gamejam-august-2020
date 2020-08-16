extends Control

signal ready_to_start

func _on_start_button_pressed():
	emit_signal("ready_to_start")
	queue_free()
