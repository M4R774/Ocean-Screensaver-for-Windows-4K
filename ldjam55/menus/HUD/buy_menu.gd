extends VBoxContainer

var MANAGER: GAME_MANAGER

var screen_size = Vector2(0, 0)
var speed = 10
var direction = Vector2(1, 1)

func _ready():
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	for item in MANAGER.ITEMS_TO_BUY:
		var label = Label.new()
		label.text = "Press A to summon " + item["name"]
		label.set("theme_override_font_sizes/font_size", 24)
		add_child(label)
	for fish in MANAGER.FISH_TO_BUY:
		var label = Label.new()
		label.text = "Press S to summon " + fish["name"]
		label.set("theme_override_font_sizes/font_size", 24)
		add_child(label)
	for plant in MANAGER.PLANTS_TO_BUY:
		var label = Label.new()
		label.text = "Press D to summon " + plant["name"]
		label.set("theme_override_font_sizes/font_size", 24)
		add_child(label)
	update_HUD()
	screen_size = get_viewport_rect().size


func _process(delta):
	update_HUD()

	screen_size = get_viewport_rect().size

	# Bounce off the screen edges
	if position.x >= screen_size.x - size.x:
		direction.x = abs(direction.x)*-1
	if position.y >= screen_size.y - size.y:
		direction.y = abs(direction.y)*-1
	if position.x <= 0:
		direction.x = abs(direction.x)
	if position.y <= 0:
		direction.y = abs(direction.y)
	position += direction * speed * delta

	handle_input()


func handle_input():
	if Input.is_action_just_pressed("summon_fish"):
		handle_buying_fish()
	
	if Input.is_action_just_pressed("summon_plant"):
		handle_buying_plant()

	if Input.is_action_just_pressed("summon_auto_feeder"):
		handle_buying_auto_feeder()


func update_HUD():
	var children = get_children()
	if MANAGER.if_any_fish_is_hungry() and MANAGER.ITEMS_TO_BUY[0]["available"] == true:
		children[0].show()
	else:
		children[0].hide()
	var children_counter = 1

	for item in MANAGER.ITEMS_TO_BUY:
		if item["price"] <= MANAGER.NUTRIENTS and item["available"] == true:
			children[children_counter].show()
		else:
			children[children_counter].hide()
		children_counter = children_counter + 1

	var fish_available = false
	for fish in MANAGER.FISH_TO_BUY:
		if fish["price"] <= MANAGER.MANA and fish["available"] and not fish_available:
			children[children_counter].show()
			fish_available = true
		else:
			children[children_counter].hide()
		children_counter = children_counter + 1

	var plant_available = false
	for plant in MANAGER.PLANTS_TO_BUY:
		if plant["price"] <= MANAGER.NUTRIENTS and plant["available"] and not plant_available:
			children[children_counter].show()
			plant_available = true
		else:
			children[children_counter].hide()
		children_counter = children_counter + 1


func handle_buying_fish():
	for fish in MANAGER.FISH_TO_BUY:
		if fish["available"]:
			if fish["price"] <= MANAGER.MANA:
				MANAGER.add_mana(-fish["price"])
				fish["available"] = false
				var new_fish = fish["scene"].instantiate()
				screen_size = get_viewport_rect().size
				get_node("/root").add_child(new_fish)
			break


func handle_buying_plant():
	# TODO
	pass


func handle_buying_auto_feeder():
	MANAGER.ITEMS_TO_BUY[0]["available"] = false
	# TODO: create a new auto feeder


func has_enough_money(price):
	return MANAGER.MONEY >= price
