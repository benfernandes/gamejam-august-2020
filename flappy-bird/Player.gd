extends KinematicBody2D

var isStopped = false
var hasStarted = false
var velocity = 0

func _ready():
	pass

func flap():
	hasStarted = true

	if velocity < 500:
		velocity = velocity + 150

func _input(event):
	if event.is_action_pressed("flap"):
		flap()

func _physics_process(delta):
	if !isStopped && hasStarted:
		var collision = move_and_collide(Vector2(0, -velocity) * delta)
		if velocity > -500:
			velocity = velocity - (400 * delta)

func stop():
	isStopped = true
