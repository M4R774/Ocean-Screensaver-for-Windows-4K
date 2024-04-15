extends Node

class_name GAME_MANAGER

var kala_1: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
var kala_2: PackedScene = preload("res://entities/kalat/kala_2/kala_2.tscn")
var kala_3: PackedScene = preload("res://entities/kalat/kala_3/kala_3.tscn")
var kala_4: PackedScene = preload("res://entities/kalat/kala_4/kala_4.tscn")

var ITEMS_TO_BUY = [
	{"name": "An Automatic Food Summoner", "price": 10, "available": true},
	{"name": "An Automatic Food Summoner", "price": 60, "available": true},
	{"name": "An Automatic Food Summoner", "price": 120, "available": true},
]

var FISH_TO_BUY = [
	{"name": "a Fish", "price": 10, "scene": kala_1, "available": true},
	{"name": "a Fish", "price": 600, "scene": kala_1, "available": true},
	{"name": "a Fish", "price": 1000, "scene": kala_2, "available": true},
	{"name": "a Fish", "price": 1000, "scene": kala_2, "available": true},
	{"name": "a Fish", "price": 2000, "scene": kala_3, "available": true},
	{"name": "a Fish", "price": 5000, "scene": kala_1, "available": true},
	{"name": "a Fish", "price": 10000, "scene": kala_2, "available": true},
	{"name": "a Fish", "price": 10000, "scene": kala_3, "available": true},
	{"name": "a Fish", "price": 20000, "scene": kala_4, "available": true},
	{"name": "a Fish", "price": 40000, "scene": kala_4, "available": true},
	{"name": "a Fish", "price": 40000, "scene": kala_4, "available": true},
	{"name": "a Fish", "price": 40000, "scene": kala_4, "available": true},
]

var PLANTS_TO_BUY = [
	{"name": "The Sun", "price": 5, "node_path": "/root/Root/background/root", "available": true, "hide_panel_path": "/root/Root/CanvasLayer/HUD/Panel"},
	{"name": "a Plant", "price": 5, "node_path": "/root/Root/Plants/Coral1", "available": true},
	{"name": "a Plant", "price": 15, "node_path": "/root/Root/Plants/Coral2", "available": true},
	{"name": "a Plant", "price": 20, "node_path": "/root/Root/Plants/Coral3", "available": true},
	{"name": "a Plant", "price": 40, "node_path": "/root/Root/Plants/Coral4", "available": true},
	{"name": "a Plant", "price": 80, "node_path": "/root/Root/Plants/Coral5", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral6", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral7", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral9", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral10", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral11", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral12", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral13", "available": true},
	{"name": "a Plant", "price": 100, "node_path": "/root/Root/Plants/Coral19", "available": true},
]

var FISHES = []
var FOOD = []
var NUTRIENTS = 0
var MANA = 10


func _ready():
	load_game_from_disk()


func add_fish(fish):
	FISHES.append(fish)
	print("Fish added, currently there are ", FISHES.size(), " fishes in the sea.")


func add_food(food):
	FOOD.append(food)
	#print("Food added, currently there are ", FOOD.size(), " food.")


func remove_fish(fish):
	FISHES.erase(fish)
	#print("Fish removed, currently there are ", FISHES.size(), " fishes in the sea.")


func remove_food(food):
	FOOD.erase(food)
	#print("Food removed, currently there is ", FOOD.size(), " food.")


func add_nutrients(amount):
	NUTRIENTS = NUTRIENTS + amount
	#print("Nutrients: ", NUTRIENTS)


func add_mana(amount):
	MANA = MANA + amount
	#print("Mana: ", MANA)


func get_closest_food(fish):
	var closest_food = null
	var closest_distance = 1000000
	if FOOD.size() == 0:
		return null
	for f in FOOD:
		var distance = fish.global_position.distance_to(f.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_food = f
	return closest_food


func if_any_fish_is_hungry():
	for fish in FISHES:
		if fish.hunger >= 100:
			return true
	return false


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		exit_screensaver_gracefully()


func _input(event):
	if Input.is_action_just_pressed("reset"):
		reset_game()
		return
	if event is InputEventKey and event.pressed:
		if (not Input.is_action_just_pressed("feed") and \
				not Input.is_action_just_pressed("summon_fish") and \
				not Input.is_action_just_pressed("summon_plant") and \
				not Input.is_action_just_pressed("summon_auto_feeder")):
			exit_screensaver_gracefully()
	if event is InputEventMouseButton:
		if event.pressed:
			exit_screensaver_gracefully()


func exit_screensaver_gracefully():
	save_game()
	get_tree().quit()


func save_game():
	# Iterate over items
	for item in ITEMS_TO_BUY:
		if item["available"] == false:
			NUTRIENTS += item["price"]
	
	# Iterate over plants
	for plant in PLANTS_TO_BUY:
		if plant["available"] == false:
			NUTRIENTS += plant["price"]

	# Iterate over fish
	for fish in FISH_TO_BUY:
		if fish["available"] == false:
			MANA += fish["price"]

	var mana_file = FileAccess.open("user://mana.save", FileAccess.WRITE)
	var nutrients_file = FileAccess.open("user://nutrients.save", FileAccess.WRITE)
	mana_file.store_var(MANA, true)
	nutrients_file.store_var(NUTRIENTS, true)


func load_game_from_disk():
	# Mana
	if not FileAccess.file_exists("user://mana.save"):
		return # Error! We don't have a save to load.
	var mana_file = FileAccess.open("user://mana.save", FileAccess.READ)
	MANA = mana_file.get_var(true)

	# Nutrients
	if not FileAccess.file_exists("user://nutrients.save"):
		return
	var nutrients_file = FileAccess.open("user://nutrients.save", FileAccess.READ)
	NUTRIENTS = nutrients_file.get_var(true)

	print("Game loaded. Mana: ", MANA, ", Nutrients: ", NUTRIENTS)


func reset_game():
	MANA = 10
	NUTRIENTS = 0
	# Iterate over items
	for item in ITEMS_TO_BUY:
		item["available"] = true

	# Iterate over plants
	for plant in PLANTS_TO_BUY:
		plant["available"] = true

	# Iterate over fish
	for fish in FISH_TO_BUY:
		fish["available"] = true

	FISHES.clear()
	get_tree().reload_current_scene()
