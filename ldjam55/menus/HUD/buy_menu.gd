extends VBoxContainer

var MANAGER: GAME_MANAGER

var screen_size = Vector2(0, 0)
var speed = 0.4
var direction = Vector2(1, 1)

func _ready():
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	for item in MANAGER.ITEMS_TO_BUY:
		var label = Label.new()
		label.text = "Press B to buy " + item["name"] + " - " + str(item["price"]) + " €"
		label.set("theme_override_font_sizes/font_size", 24)
		add_child(label)
	update_HUD()
	screen_size = get_viewport_rect().size


func _process(delta):
	# update HUD rarely
	if randf() < 0.005:
		update_HUD()

	screen_size = get_viewport_rect().size

	# Bounce off the screen edges
	if position.x >= screen_size.x - size.x:
		direction.x *= -1
	if position.y >= screen_size.y - size.y:
		direction.y *= -1
	if position.x <= 0:
		direction.x *= -1
	if position.y <= 0:
		direction.y *= -1
	
	position += direction * speed * delta


func update_HUD():
	# TODO: If one of the fish is VERY hungry, show feeding prompt

	var children_counter = 1
	var children = get_children()
	for item in MANAGER.ITEMS_TO_BUY:
		if item["price"] <= MANAGER.MONEY:
			children[children_counter].show()
		else:
			children[children_counter].hide()
		children_counter += 1