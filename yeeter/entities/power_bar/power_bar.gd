extends ProgressBar

var is_playing = true
var direction = 1

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

# Remaining display
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

func _process(delta):
	var new_value = value
	
	if (Input.is_action_pressed("ui_select") || get_parent().fire_button.pressed) && is_playing:
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
		shoot()

func _on_remaining_none_remaining():
	is_playing = false


func _on_Fire_button_up():
	if is_playing:
		shoot()

func shoot():
	if remaining.get_value() > 0:
		bird_cannon.shoot()
		remaining.decrement_value()
		value = 0
