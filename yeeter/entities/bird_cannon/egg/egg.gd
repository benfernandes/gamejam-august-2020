extends RigidBody2D

const GRAVITY = 5
const AIR_RESISTANCE = 0.1
var _velocity = Vector2()

func _process(delta):
	#print(position.y)
	pass

func shoot(initial_velocity, angle):
	rotation_degrees = angle
	apply_central_impulse(initial_velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
