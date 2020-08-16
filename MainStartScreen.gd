extends CanvasLayer

signal begin

func _on_StartButton_pressed():
	$StartButton.hide()
	$GameTitleLabel.hide()
	$NestAndBird.hide()
	emit_signal("begin")
