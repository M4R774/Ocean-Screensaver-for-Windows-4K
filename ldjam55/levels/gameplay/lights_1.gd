extends Sprite2D

var rng = RandomNumberGenerator.new()
@export var flashspeed = 10
@export var counter = 0
@export var min = 0.6
@export var max = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if counter < flashspeed:
		counter += 1
	else:
		counter = 0
		modulate.a = rng.randf_range(0.6, 1.0)
	
