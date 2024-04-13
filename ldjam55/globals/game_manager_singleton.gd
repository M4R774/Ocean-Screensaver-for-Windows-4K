extends Node

class_name GAME_MANAGER

# Kala_1: 10 €;
var kala_1: PackedScene = preload("res://entities/kalat/kala_1/kala_1.tscn")
#var kasvi_1: PackedScene = preload("res://entities/kasvi_1/kasvi_1.tscn")
var kala_2: PackedScene = preload("res://entities/kalat/kala_2/kala_2.tscn")
#var kasvi_2: PackedScene = preload("res://entities/kasvi_2/kasvi_2.tscn")
var kala_3: PackedScene = preload("res://entities/kalat/kala_3/kala_3.tscn")
#var kasvi_3: PackedScene = preload("res://entities/kasvi_3/kasvi_3.tscn")
var ITEMS_TO_BUY = [
	{"name": "Fish", "price": 3, "scene": kala_1, "available": true},
	#{"name": "Plant", "price": 10, "scene": kasvi_1, "available": true},
	{"name": "Fish", "price": 4, "scene": kala_2, "available": true},
	#{"name": "Plant", "price": 20, "scene": kasvi_2, "available": true},
	{"name": "Fish", "price": 5, "scene": kala_3, "available": true},
	#{"name": "Plant", "price": 30, "scene": kasvi_3, "available": true}
]

var FISHES = []
var FOOD = []
var MONEY = 0


func add_fish(fish):
	FISHES.append(fish)
	print("Fish added, currently there are ", FISHES.size(), " fishes in the tank.")


func add_food(food):
	FOOD.append(food)
	print("Food added, currently there are ", FOOD.size(), " food in the tank.")


func remove_fish(fish):
	FISHES.erase(fish)
	print("Fish removed, currently there are ", FISHES.size(), " fishes in the tank.")


func remove_food(food):
	FOOD.erase(food)
	print("Food removed, currently there are ", FOOD.size(), " food in the tank.")


func add_money(amount):
	MONEY += amount
	print("Money added, currently there are ", MONEY, " money in the tank.")


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
