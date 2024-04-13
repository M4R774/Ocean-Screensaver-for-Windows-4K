extends Node

class_name ENTITIES_LIST

# List of fishes
var FISHES = []

# List of available food for the fish
var FOOD = []


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
