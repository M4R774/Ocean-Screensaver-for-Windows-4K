extends CharacterBody2D

var MANAGER: GAME_MANAGER

@export var speed = 50
var wandering_target: Vector2 = Vector2(0, 0)
var food_target: Node2D
var screen_size = Vector2(0, 0)
var hunger = 20
var max_hunger = 200
var hunger_timer: Timer
var animated_sprite: AnimatedSprite2D


func _ready():
	speed += randf_range(-10.0, 20.0)
	animated_sprite = get_node("AnimatedSprite")
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	MANAGER.add_fish(self)
	screen_size = get_viewport_rect().size
	global_position = screen_size / 2
	wandering_target = Vector2(randi() % int(screen_size.x + 200), randi() % int(screen_size.y))
	add_timer_for_hunger()


func _physics_process(_delta):
	if velocity.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

	# Hunting for food
	if food_target != null:
		if global_position.distance_to(food_target.global_position) < 30:
			food_target.remove()
			food_target = null
			hunger -= 40
			MANAGER.add_nutrients(1)
			return
		velocity = (food_target.global_position - global_position).normalized() * speed * 3
		move_and_slide()
		return

	# Wandering
	if global_position.distance_to(wandering_target) < 10:
		wandering_target = Vector2(randi() % int(screen_size.x + 200), randi() % int(screen_size.y))
	velocity = (wandering_target - global_position).normalized() * speed

	move_and_slide()


func add_timer_for_hunger():
	hunger_timer = Timer.new()
	add_child(hunger_timer)
	hunger_timer.set_wait_time(1)
	hunger_timer.set_one_shot(false)
	hunger_timer.connect("timeout", self._on_timer_timeout)
	hunger_timer.start()


func _on_timer_timeout() -> void:
	increase_hunger()


func increase_hunger():
	hunger += 1
	if hunger > 60 and food_target == null:
		food_target = MANAGER.get_closest_food(self)
	if hunger > 200:
		hunger = 200


func remove_fish():
	MANAGER.remove_fish(self)
	queue_free()
