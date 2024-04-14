extends StaticBody2D

var MANAGER: GAME_MANAGER

var speed = 20.0
var screen_size = Vector2(0, 0)


func _ready():
	speed += randf_range(-5.0, 5.0)
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	MANAGER.add_food(self)
	screen_size = get_viewport().get_visible_rect().size
	rotation = randf() * 2 * PI


func _process(delta):
	global_position.y += speed * delta
	if position.y > screen_size.y + 10:
		remove()


func remove():
	MANAGER.remove_food(self)
	queue_free()
