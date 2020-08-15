extends Node2D

var obstacle_timer
var goal_timer
var difficulty_timer

var speed = 100
var obstacles
var goal

func _ready():
	hide()
	obstacles = [
		preload("./Obstacles/Bramble.tscn"),
		preload("./Obstacles/Branch1.tscn"),
		preload("./Obstacles/Branch2.tscn"),
		preload("./Obstacles/CampFire.tscn"),
		preload("./Obstacles/Flower.tscn"),
		preload("./Obstacles/Rock.tscn"),
		preload("./Obstacles/Sunflower.tscn"),
		preload("./Obstacles/Vine.tscn"),
	]
	goal = preload("./Goal.tscn")

func start():
	show()
	create_obstacle()

	obstacle_timer = Timer.new()
	add_child(obstacle_timer)
	obstacle_timer.connect("timeout", self, "create_obstacle")
	obstacle_timer.set_wait_time(3)
	obstacle_timer.set_one_shot(false) # Make sure it loops
	obstacle_timer.start()

	goal_timer = Timer.new()
	add_child(goal_timer)
	goal_timer.connect("timeout", self, "prepare_goal")
	goal_timer.set_wait_time(60.0)
	goal_timer.set_one_shot(false) # Make sure it loops
	goal_timer.start()

	difficulty_timer = Timer.new()
	add_child(difficulty_timer)
	difficulty_timer.connect("timeout", self, "increase_difficulty")
	difficulty_timer.set_wait_time(2.5)
	difficulty_timer.set_one_shot(false) # Make sure it loops
	difficulty_timer.start()

func increase_difficulty():
	speed = speed + 10
	obstacle_timer.set_wait_time(obstacle_timer.get_wait_time() - 0.1)

func create_obstacle():
	var index = randi() % obstacles.size()
	var obstacle = obstacles[index].instance()
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
