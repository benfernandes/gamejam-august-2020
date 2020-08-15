extends ProgressBar

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

# Remaining display
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

func _process(delta):
	var new_value = value
	
	if Input.is_action_pressed("ui_select"):
		new_value += 2
	else:
		new_value -= 2
		
	value = clamp(new_value, 0, 100)
	
	if Input.is_action_just_released("ui_select"):
		if remaining.get_value() > 0:
			bird_cannon.shoot()
			remaining.decrement_value()
			value = 0
