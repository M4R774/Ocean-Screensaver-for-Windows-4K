extends StaticBody2D

var MANAGER: GAME_MANAGER

var speed = 100
var screen_size = Vector2(0, 0)


func _ready():
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	MANAGER.add_food(self)
	screen_size = get_viewport().get_visible_rect().size


func _process(delta):
	position.y += speed * delta
	if position.y > screen_size.y:
		remove()


func remove():
	MANAGER.remove_food(self)
	queue_free()
