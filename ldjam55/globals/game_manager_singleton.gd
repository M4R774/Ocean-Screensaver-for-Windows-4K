extends Node

class_name GAME_MANAGER

# Kala_1: 10 €;
var kala_1: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
var kala_2: PackedScene = preload("res://entities/kalat/kala_2/kala_2.tscn")
var kala_3: PackedScene = preload("res://entities/kalat/kala_3/kala_3.tscn")

var ITEMS_TO_BUY = [
	{"name": "An Automatic Food Summoner", "price": 10, "available": true},
	{"name": "An Automatic Food Summoner", "price": 60, "available": true},
	{"name": "An Automatic Food Summoner", "price": 120, "available": true},
	{"name": "An Automatic Food Summoner", "price": 240, "available": true},
]

var FISH_TO_BUY = [
	{"name": "a Fish", "price": 5, "scene": kala_1, "available": true},
	{"name": "a Fish", "price": 5, "scene": kala_1, "available": true},
	{"name": "a Fish", "price": 5, "scene": kala_2, "available": true},
	{"name": "a Fish", "price": 5, "scene": kala_2, "available": true},
]

var PLANTS_TO_BUY = [
	{"name": "The Sun", "price": 5, "node_path": "/root/Root/background/root", "available": true, "hide_panel_path": "/root/Root/CanvasLayer/HUD/Panel"},
	{"name": "a Plant", "price": 5, "node_path": "/root/Root/Plants/Coral1", "available": true},
	{"name": "a Plant", "price": 20, "node_path": "/root/Root/Plants/Coral2", "available": true},
	{"name": "a Plant", "price": 40, "node_path": "/root/Root/Plants/Coral3", "available": true},
	{"name": "a Plant", "price": 80, "node_path": "/root/Root/Plants/Coral4", "available": true},
	{"name": "a Plant", "price": 160, "node_path": "/root/Root/Plants/Coral5", "available": true},
	{"name": "a Plant", "price": 320, "node_path": "/root/Root/Plants/Coral6", "available": true},
	{"name": "a Plant", "price": 640, "node_path": "/root/Root/Plants/Coral7", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral9", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral10", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral11", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral12", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral13", "available": true},
	{"name": "a Plant", "price": 1000, "node_path": "/root/Root/Plants/Coral19", "available": true},
]

var FISHES = []
var FOOD = []
var NUTRIENTS = 0
var MANA = 10


func add_fish(fish):
	FISHES.append(fish)
	print("Fish added, currently there are ", FISHES.size(), " fishes in the sea.")


func add_food(food):
	FOOD.append(food)
	# print("Food added, currently there are ", FOOD.size(), " food.")


func remove_fish(fish):
	FISHES.erase(fish)
	print("Fish removed, currently there are ", FISHES.size(), " fishes in the sea.")


func remove_food(food):
	FOOD.erase(food)
	# print("Food removed, currently there is ", FOOD.size(), " food.")


func add_nutrients(amount):
	NUTRIENTS = NUTRIENTS + amount
	print("Nutrients: ", NUTRIENTS)


func add_mana(amount):
	MANA = MANA + amount
	print("Mana: ", MANA)


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
