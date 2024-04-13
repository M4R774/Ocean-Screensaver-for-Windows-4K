extends CharacterBody2D

var MANAGER: GAME_MANAGER

var speed = 400
var wandering_target: Vector2 = Vector2(0, 0)
var food_target: Node2D
var screen_size = Vector2(0, 0)
var hunger = 0
var hunger_timer: Timer


func _ready():
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	MANAGER.add_fish(self)
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	wandering_target = Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))
	add_timer_for_hunger()


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
	hunger += 2
	if hunger > 30 and food_target == null:
		food_target = MANAGER.get_closest_food(self)
	if hunger > 100:
		hunger = 100


func _physics_process(_delta):
	# Hunting for food
	if food_target != null:
		if position.distance_to(food_target.position) < 50:
			food_target.remove()
			food_target = null
			hunger -= 40
			MANAGER.add_money(1)
			return
		velocity = (food_target.position - position).normalized() * speed
		move_and_slide()
		return

	# Wandering
	if position.distance_to(wandering_target) < 10:
		wandering_target = Vector2(randi() % int(screen_size.x), randi() % int(screen_size.y))
	velocity = (wandering_target - position).normalized() * speed
	move_and_slide()


func eat():
	hunger = 0


func remove_fish():
	MANAGER.remove_fish(self)
	queue_free()
