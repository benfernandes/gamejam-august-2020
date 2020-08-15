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

	obstacle_timer = create_timer(3.0, "create_obstacle", true)
	goal_timer = create_timer(60.0, "prepare_goal", true)
	difficulty_timer = create_timer(2.5, "increase_difficulty", true)

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
	create_timer(2.0, "create_goal", false)

func create_goal():
	var goal_instance = goal.instance()
	add_child(goal_instance)
	goal_instance.set_speed(speed)

func game_over():
	get_parent().game_over()

func create_timer(timeout, callback, shouldRepeat):
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, callback)
	timer.set_wait_time(timeout)
	timer.set_one_shot(!shouldRepeat)
	timer.start()
	return timer
