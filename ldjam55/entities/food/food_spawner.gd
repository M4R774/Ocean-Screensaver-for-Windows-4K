extends Node2D

@export var food_prefab: PackedScene = preload("res://entities/food/food.tscn")

var screen_size = Vector2(0, 0)


func _ready():
	screen_size = get_viewport_rect().size


func _process(_delta):
	if Input.is_action_just_pressed("feed"):
		spawn_food()


func spawn_food():
	screen_size = get_viewport_rect().size
	var food = food_prefab.instantiate()
	food.position = Vector2(randi() % int(screen_size.x), 0)
	add_child(food)
