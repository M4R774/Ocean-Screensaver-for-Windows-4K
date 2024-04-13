extends CharacterBody2D

var ENTITIES: ENTITIES_LIST

var speed = 400
var target: Vector2 = Vector2(0,0)
var screen_size = Vector2(300, 300)


func _ready():
	ENTITIES = get_node("/root/ENTITIES_LIST_SINGLETON")
	ENTITIES.add_fish(self)
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	target = Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))


func _physics_process(_delta):
	if distance_to_target() < 10:
		target = Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))
	velocity = (target - position).normalized() * speed
	move_and_slide()


func distance_to_target():
	return position.distance_to(target)


func remove_fish():
	ENTITIES.remove_fish(self)
	queue_free()
