extends VBoxContainer

var screen_size = Vector2(0, 0)
var speed = 0.4
var direction = Vector2(1, 1)


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
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

