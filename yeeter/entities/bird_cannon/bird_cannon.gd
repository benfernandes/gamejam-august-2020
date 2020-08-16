extends KinematicBody2D

var is_playing = true

# Egg scene
export (PackedScene) var egg_scene

# Egg spawn
export (NodePath) var egg_spawn_path
onready var egg_spawn = get_node(egg_spawn_path)

# Power bar
export (NodePath) var power_bar_path
onready var power_bar = get_node(power_bar_path)

func _ready():
	$EasySprite.hide();
	$MediumSprite.hide();
	$HardSprite.hide();

func _get_vector(magnitude, angle):
	var x_vector = _get_x_vector(magnitude, angle)
	var y_vector = _get_y_vector(magnitude, angle)
	return Vector2(x_vector, y_vector)
	
func _get_x_vector(magnitude, angle_degs):
	return magnitude * cos(_get_rads_from_degs(angle_degs))
	
func _get_y_vector(magnitude, angle_degs):
	# We negate the Y vector because Y increases from the top down
	return - (magnitude * sin(_get_rads_from_degs(angle_degs)))

func _get_rads_from_degs(degs):
	return (degs * PI) / 180

func _process(delta):
	if Input.is_action_pressed("ui_left") && is_playing:
		rotation_degrees -= 1
	if Input.is_action_pressed("ui_right") && is_playing:
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
	
	global_rotation_degrees += remap_range(power_bar.value, 0, 100, 0, 10)

func remap_range(input, minInput, maxInput, minOutput, maxOutput):
	return(input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput

func _on_remaining_none_remaining():
	is_playing = false

func set_difficulty(difficulty):
	match difficulty:
		"easy":
			$EasySprite.show()
		"medium":
			$MediumSprite.show()
		"hard":
			$HardSprite.show()
