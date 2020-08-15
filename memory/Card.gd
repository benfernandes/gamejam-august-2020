extends Area2D

var allow_click
var front_image
var back_image
var card_name

func _ready():
	card_name = "Not initialized"
	allow_click = true
	front_image = preload("res://assets/memory/card-back.png")
	back_image = preload("res://assets/memory/card-back.png")
	get_node("Sprite").texture = back_image

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	if allow_click:
		allow_click = false
		get_node("Sprite").texture = front_image
		if (get_parent().selected_card1_image == "Card 1"):
			get_parent().selected_card1_image = card_name
			get_parent().selected_card1 = name
		elif (get_parent().selected_card2_image == "Card 2"):
			get_parent().selected_card2_image = card_name
			get_parent().selected_card2 = name
			get_parent().check_if_match()

func show_front_image():
	get_node("Sprite").texture = front_image
