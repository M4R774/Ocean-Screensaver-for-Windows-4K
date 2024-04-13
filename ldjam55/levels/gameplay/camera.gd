extends Node2D
var max_offset_x = 1500
var max_offset_y = 80
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

	position += Vector2(movement_x * delta, cos(position.x / max_offset_x * PI) * movement_y  * delta)

	print(cos(position.x))
	
