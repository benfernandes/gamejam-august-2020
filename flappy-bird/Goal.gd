extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_speed(newSpeed):
	speed = newSpeed

func _physics_process(delta):
	var collision = move_and_collide(Vector2(-speed, 0) * delta)
	if collision:
		print("Goal!")

