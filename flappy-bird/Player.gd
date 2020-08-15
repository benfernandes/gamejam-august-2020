extends RigidBody2D

func _ready():
	pass

func flap():
	set_linear_velocity(Vector2(0, -150))

func _input(event):
	if event.is_action_pressed("flap"):
		flap()
