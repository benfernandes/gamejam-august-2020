extends KinematicBody2D

var isStopped = false
var hasStarted = false
var velocity = 0

func _ready():
	pass

func flap():
	hasStarted = true

	if velocity < 400:
		velocity = velocity + 200
		if velocity > 400:
			velocity = 400

func _input(event):
	if event.is_action_pressed("flap"):
		flap()

func _physics_process(delta):
	if !isStopped && hasStarted:
		var collision = move_and_collide(Vector2(0, -velocity) * delta)
		if velocity > -400:
			velocity = velocity - (400 * delta)
		set_bird_angle()


func stop():
	isStopped = true
	
func set_bird_angle():
	var min_velocity = -100
	var max_velocity = 100
	var min_angle = 30
	var max_angle = -20
	var clamped_velocity = clamp(velocity, min_velocity, max_velocity)
	
	global_rotation_degrees = remap_range(clamped_velocity, min_velocity, max_velocity, min_angle, max_angle)

func remap_range(input, minInput, maxInput, minOutput, maxOutput):
	return(input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput
