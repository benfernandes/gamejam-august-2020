extends Control

# Remaining bar
export (NodePath) var remaining_path
onready var remaining = get_node(remaining_path)

# Bird cannon
export (NodePath) var bird_cannon_path
onready var bird_cannon = get_node(bird_cannon_path)

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		print("Number of eggs")
		print(get_tree().get_nodes_in_group("eggs").size())

func _on_remaining_none_remaining():
	get_parent().show_main_screen()
	queue_free()
