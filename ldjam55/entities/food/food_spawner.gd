extends Node2D

var MANAGER: GAME_MANAGER

@export var food_prefab: PackedScene = preload("res://entities/food/food.tscn")

var screen_size = Vector2(0, 0)

func _ready():
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	var timer = Timer.new()
	timer.wait_time = 10
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)


func _process(_delta):
	if Input.is_action_just_pressed("feed"):
		spawn_food()


func _on_timer_timeout():
	if not MANAGER.ITEMS_TO_BUY[0]["available"]:
		for i in range(3):
			spawn_food()


func spawn_food():
	screen_size = get_viewport_rect().size
	var food = food_prefab.instantiate()
	food.position = Vector2(randi() % int(screen_size.x) + global_position.x, 0)
	get_node("/root").add_child(food)
