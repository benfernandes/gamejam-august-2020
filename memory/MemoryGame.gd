extends Node2D

var images
var card_default
var card_default_easy
var card_default_medium
var card_default_hard
var number_of_cards
var selected_card1
var selected_card2
var selected_card1_image
var selected_card2_image
var number_of_matches

func _ready():
	selected_card1_image = "Card 1"
	selected_card2_image = "Card 2"
	card_default = preload("res://assets/memory/card-back.png")
	card_default_easy = preload("res://assets/memory/card-back.png")
	card_default_medium = preload("res://assets/memory/card-back-medium.png")
	card_default_hard = preload("res://assets/memory/card-back-hard.png")
	images = [
		{
			"image": preload("res://assets/memory/leaf-1-card.png"),
			"name": "Green Leaf"
		},
		{
			"image": preload("res://assets/memory/leaf-2-card.png"),
			"name": "Red Leaf"
		},
		{
			"image": preload("res://assets/memory/sun-card.png"),
			"name": "Sun"
		},
		{
			"image": preload("res://assets/memory/bird-feeder-card.png"),
			"name": "Bird Feeder"
		},
		{
			"image": preload("res://assets/memory/twig-1-card.png"),
			"name": "Branch"
		},
		{
			"image": preload("res://assets/memory/twig-2-card.png"),
			"name": "Twig"
		},
		{
			"image": preload("res://assets/memory/water-card.png"),
			"name": "Water"
		},
		{
			"image": preload("res://assets/memory/worm-card.png"),
			"name": "Worm"
		}
	]
	number_of_cards = 16
	shuffle_cards()

func set_back_image(difficulty):
	match difficulty:
		"easy":
			card_default = card_default_easy
		"medium":
			card_default = card_default_medium
		"hard":
			card_default = card_default_hard
	for i in range(number_of_cards):
		var card = "Card" + String(i)
		get_node(card).set_back_image(card_default)

	
func shuffle_cards():
	var card_numbers = range(number_of_cards)
	card_numbers.shuffle()
	
	for i in range(number_of_cards / 2):
		var pair_card1 = "Card" + String(card_numbers[2*i])
		var pair_card2 = "Card" + String(card_numbers[2*i+1])
		get_node(pair_card1).front_image = images[i].image
		get_node(pair_card1).card_name = images[i].name
		get_node(pair_card2).front_image = images[i].image
		get_node(pair_card2).card_name = images[i].name
		
func check_if_match():
	disable_card_clicks()
	var matched = selected_card1_image == selected_card2_image
	if matched:
		get_parent().add_match()
		
	var waiting_timer = Timer.new()
	waiting_timer.set_wait_time(1)
	waiting_timer.set_one_shot(true)
	self.add_child(waiting_timer)
	waiting_timer.start()
	
	yield(waiting_timer, "timeout")
	reset_selected_card_vars()
	handle_selected_cards(matched)
	enable_card_clicks()
		
func disable_card_clicks():
	for i in range(number_of_cards):
		var card = "Card" + String(i)
		get_node(card).allow_click = false
		
func reset_selected_card_vars():
	selected_card1_image = "Card 1"
	selected_card2_image = "Card 2"
	
func handle_selected_cards(matched):
	if (matched):
		get_node(selected_card1).visible = false
		get_node(selected_card2).visible = false
	else:
		get_node(selected_card1).get_node("Sprite").texture = card_default
		get_node(selected_card2).get_node("Sprite").texture = card_default
	
func enable_card_clicks():
	for i in range(number_of_cards):
		var card = "Card" + String(i)
		if (get_node(card).get_node("Sprite").texture == card_default):
			get_node(card).allow_click = true
	
func show_all_cards():
	for i in range(number_of_cards):
		var card = "Card" + String(i)
		get_node(card).show_front_image()
