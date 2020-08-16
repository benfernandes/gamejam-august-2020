extends CanvasLayer

signal begin

func _on_StartButton_pressed():
	$StartButton.hide()
	$GameTitleLabel.hide()
	emit_signal("begin")
