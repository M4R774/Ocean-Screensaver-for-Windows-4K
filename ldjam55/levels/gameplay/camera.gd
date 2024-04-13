extends Control
var max_offset_x = 275
var max_offset_y = 55
var movement_x = 10
var movement_y = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > max_offset_x or position.x < 0:
		movement_x *= -1

	if position.y > max_offset_y or position.y < 0:
		movement_y *= -1

	global_position += Vector2(movement_x * delta, movement_y  * delta)
