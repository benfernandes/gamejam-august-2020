extends Node2D

var obstacle_timer
var goal_timer
var difficulty_timer
var prepare_goal_timer = null

var config
var easy_config = {
	"game_time": 30,
	"obstacle_start_time": 5,
	"start_speed": 75,
	"speed_increase": 20,
	"spawn_time_decrease": 0.15
}
var medium_config = {
	"game_time": 60,
	"obstacle_start_time": 4,
	"start_speed": 75,
	"speed_increase": 10,
	"spawn_time_decrease": 0.1
}
var hard_config = {
	"game_time": 60,
	"obstacle_start_time": 3,
	"start_speed": 100,
	"speed_increase": 10,
	"spawn_time_decrease": 0.1
}

var speed
var obstacles
var current_obstacles = []
var goal
var goal_instance = null
var player

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

func start(difficulty):
	if (difficulty == "easy"):
		config = easy_config
		var easy_player = preload("./Players/EasyPlayer.tscn")
		player = easy_player.instance()
	if (difficulty == "medium"):
		config = medium_config
		var medium_player = preload("./Players/MediumPlayer.tscn")
		player = medium_player.instance()
	if (difficulty == "hard"):
		config = hard_config
		var hard_player = preload("./Players/HardPlayer.tscn")
		player = hard_player.instance()
	add_child(player)

	speed = config.start_speed
	obstacle_timer = create_timer(config.obstacle_start_time, "create_obstacle", true, [])
	goal_timer = create_timer(config.game_time, "prepare_goal", true, [])
	difficulty_timer = create_timer(2.5, "increase_difficulty", true, [])

	show()
	create_obstacle()

func increase_difficulty():
	speed = speed + config.speed_increase
	obstacle_timer.set_wait_time(obstacle_timer.get_wait_time() - config.spawn_time_decrease)
	for obstacle in current_obstacles:
	  obstacle.set_speed(speed)

func create_obstacle():
	var index = randi() % obstacles.size()
	var obstacle = obstacles[index].instance()
	add_child(obstacle)
	current_obstacles.push_back(obstacle)
	obstacle.set_speed(speed)

func prepare_goal():
	obstacle_timer.stop()
	goal_timer.stop()
	prepare_goal_timer = create_timer(2.0, "create_goal", false, [])

func create_goal():
	goal_instance = goal.instance()
	add_child(goal_instance)
	goal_instance.set_speed(speed)

func game_over():
	stop_scene()
	create_timer(5.0, "return_to_main_menu", false, [false])

func level_complete():
	stop_scene()
	create_timer(5.0, "return_to_main_menu", false, [true])

func return_to_main_menu(has_won):
	get_parent().game_over(has_won)

func stop_scene():
	obstacle_timer.stop()
	goal_timer.stop()
	difficulty_timer.stop()

	if prepare_goal_timer != null:
		prepare_goal_timer.stop()
	if goal_instance != null:
		goal_instance.stop()
	player.stop()
	for obstacle in current_obstacles:
	  obstacle.stop()

func create_timer(timeout, callback, shouldRepeat, params):
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, callback, params)
	timer.set_wait_time(timeout)
	timer.set_one_shot(!shouldRepeat)
	timer.start()
	return timer
