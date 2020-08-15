extends ProgressBar

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

func _process(delta):
	var new_value = value
	
	if Input.is_action_pressed("ui_select"):
		new_value += 2
	else:
		new_value -= 2
		
	value = clamp(new_value, 0, 100)
	
	if Input.is_action_just_released("ui_select"):
		bird_cannon.shoot()
	
	set_color()

# TODO - Make the colour change when the power is in this range
func set_color():
	if value >= 65 && value <= 75:
		pass
	else:
		pass
