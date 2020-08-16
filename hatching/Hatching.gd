extends Node2D

signal game_finished(game_name, has_won)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var difficulty = "easy"
var follow = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Path2D/Follow/EasyBird.hide()
	$Path2D/Follow/MediumBird.hide()
	$Path2D/Follow/HardBird.hide()

func start():
	$Egg.play("default")

func _on_ContinueButton_pressed():
	emit_signal("game_finished", "hatch", true)

func _on_Egg_animation_finished():
	if difficulty == "easy":
		$Path2D/Follow/EasyBird.show()
	if difficulty == "medium":
		$Path2D/Follow/MediumBird.show()
	if difficulty == "hard":
		$Path2D/Follow/HardBird.show()
	follow = true

func _process(delta):
	if follow:
		$Path2D/Follow.unit_offset += (0.5 * delta)
		if $Path2D/Follow.unit_offset > 1:
			$Path2D/Follow.unit_offset = 1
			follow = false
