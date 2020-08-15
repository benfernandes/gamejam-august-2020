extends RigidBody2D

const GRAVITY = 5
const AIR_RESISTANCE = 0.1
var _velocity = Vector2()

func shoot(initial_velocity, angle):
	rotation_degrees = angle
	apply_central_impulse(initial_velocity)
	#velocity = initial_velocity

	#_velocity = initial_velocity
	
#func _physics_process(delta):
	#_velocity.y += delta * GRAVITY
	#var new_x_velocity = (_velocity.x - (delta * AIR_RESISTANCE))
	#_velocity.x = max(new_x_velocity, 0)
	
	#move_and_collide(_velocity)
