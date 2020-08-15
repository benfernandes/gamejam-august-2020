extends KinematicBody2D

# Egg scene
export (PackedScene) var egg_scene

# Egg spawn
export (NodePath) var egg_spawn_path
onready var egg_spawn = get_node(egg_spawn_path)

# Power bar
export (NodePath) var power_bar_path
onready var power_bar = get_node(power_bar_path)

func _get_vector(magnitude, angle):
	var x_vector = _get_x_vector(magnitude, angle)
	var y_vector = -_get_y_vector(magnitude, angle)
	return Vector2(x_vector, y_vector)
	
func _get_x_vector(magnitude, angle_degrees):
	return magnitude * cos((angle_degrees * PI) / 180)
	
func _get_y_vector(magnitude, angle_degrees):
	return magnitude * sin((angle_degrees * PI) / 180)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= 1
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += 1

func _get_real_angle_from_global_rotation(angle):
	if angle < 0:
		return abs(angle)
	if angle > 0:
		return 360 - angle
	else:
		return angle

func shoot():
	var real_angle = _get_real_angle_from_global_rotation(global_rotation_degrees)
	var initial_vector = _get_vector(power_bar.value * 5, real_angle)
	var egg = egg_scene.instance()
	egg.global_position = egg_spawn.global_position
	egg.shoot(initial_vector, rotation_degrees)
	get_parent().add_child(egg)
