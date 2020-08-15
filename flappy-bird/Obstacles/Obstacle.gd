extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)

	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.set_wait_time(10.0)
	timer.start()

func _on_Timer_timeout():
	get_parent().remove_child(self)

func set_speed(newSpeed):
	speed = newSpeed

func _physics_process(delta):
	var collision = move_and_collide(Vector2(-speed, 0) * delta)
	if collision:
		print("Collision!")
		get_parent().game_over()	
