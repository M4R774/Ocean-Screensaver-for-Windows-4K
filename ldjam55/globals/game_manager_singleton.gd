extends Node

class_name GAME_MANAGER

# Kala_1: 10 €;
var kala_1: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
#var kasvi_1: PackedScene = preload("res://entities/kasvi_1/kasvi_1.tscn")
var kala_2: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
#var kasvi_2: PackedScene = preload("res://entities/kasvi_2/kasvi_2.tscn")
var kala_3: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
#var kasvi_3: PackedScene = preload("res://entities/kasvi_3/kasvi_3.tscn")
var ITEMS_TO_BUY = [
	{"name": "An Automatic Food Summoner", "price": 10, "scene": null, "available": true},
]

var FISH_TO_BUY = [
	{"name": "a Fish", "price": 10, "scene": kala_1, "available": true},
	{"name": "a Fish for summoning nutrients for plants", "price": 20, "scene": kala_2, "available": true},
	{"name": "a Fish for summoning nutrients for plants", "price": 40, "scene": kala_3, "available": true}
]

var PLANTS_TO_BUY = [
	{"name": "a Plant for producing mana for summoning Fish", "price": 14, "scene": null, "available": true},
	{"name": "a Plant for producing mana for summoning Fish", "price": 28, "scene": null, "available": true},
	{"name": "a Plant for producing mana for summoning Fish", "price": 56, "scene": null, "available": true}
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
