extends ProgressBar

var is_playing = false
var direction = 1

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

# Remaining display
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

func _process(delta):
	var new_value = value
	
	if Input.is_action_pressed("ui_select") && is_playing:
		new_value += 2.5 * direction
	else:
		new_value -= 2.5
		direction = 1
		
	value = clamp(new_value, 0, 100)
	
	if value == 100:
		direction = -1
	elif value == 0:
		direction = 1
	
	if Input.is_action_just_released("ui_select") && is_playing:
		if remaining.get_value() > 0:
			bird_cannon.shoot()
			remaining.decrement_value()

func _on_start_overlay_ready_to_start():
	is_playing = true

func _on_remaining_none_remaining():
	is_playing = false
