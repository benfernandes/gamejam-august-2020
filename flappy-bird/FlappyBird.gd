extends Node2D

var obstacle_timer
var goal_timer
var difficulty_timer

var speed = 100
var branch1
var goal

func _ready():
	hide()
	branch1 = preload("./Obstacles/Branch1.tscn")
	goal = preload("./Goal.tscn")

func start():
	show()
	create_obstacle()

	obstacle_timer = Timer.new()
	add_child(obstacle_timer)
	obstacle_timer.connect("timeout", self, "create_obstacle")
	obstacle_timer.set_wait_time(3.0)
	obstacle_timer.set_one_shot(false) # Make sure it loops
	obstacle_timer.start()

	goal_timer = Timer.new()
	add_child(goal_timer)
	goal_timer.connect("timeout", self, "prepare_goal")
	goal_timer.set_wait_time(40.0)
	goal_timer.set_one_shot(false) # Make sure it loops
	goal_timer.start()

	difficulty_timer = Timer.new()
	add_child(difficulty_timer)
	difficulty_timer.connect("timeout", self, "increase_difficulty")
	difficulty_timer.set_wait_time(5.0)
	difficulty_timer.set_one_shot(false) # Make sure it loops
	difficulty_timer.start()

func increase_difficulty():
	speed = speed + 20

func create_obstacle():
	var obstacle = branch1.instance()
	add_child(obstacle)
	obstacle.set_speed(speed)

func prepare_goal():
	print("prepare goal")
	obstacle_timer.stop()
	goal_timer.stop()
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.connect("timeout", self, "create_goal")
	new_timer.set_wait_time(3.0)
	new_timer.set_one_shot(true) # Make sure it doesn't loop
	new_timer.start()

func create_goal():
	var goal_instance = goal.instance()
	add_child(goal_instance)
	goal_instance.set_speed(speed)

func game_over():
	get_parent().game_over()
