extends StaticBody2D

var ENTITIES: GAME_MANAGER

var speed = 100
var screen_size = Vector2(0, 0)


func _ready():
	ENTITIES = get_node("/root/ENTITIES_LIST_SINGLETON")
	ENTITIES.add_food(self)
	screen_size = get_viewport().get_visible_rect().size


func _process(delta):
	position.y += speed * delta

	# Destroy if off screen
	if position.y > screen_size.y:
		ENTITIES.remove_food(self)
		queue_free()
