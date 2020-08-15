extends ProgressBar

export (NodePath) var remaining_label_path
onready var remaining_label = get_node(remaining_label_path)

func _ready():
	var number_of_eggs = 20
	max_value = number_of_eggs
	value = number_of_eggs

func decrement_value():
	value -= 1

func _on_remaining_bar_value_changed(value):
	remaining_label.text = str(value)
