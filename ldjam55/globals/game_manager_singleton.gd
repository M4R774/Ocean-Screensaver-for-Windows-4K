extends Node

class_name GAME_MANAGER

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
