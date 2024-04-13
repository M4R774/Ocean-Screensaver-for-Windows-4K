extends Sprite2D

var rng = RandomNumberGenerator.new()
@export var flash_multiplier = 1.0

func _ready():
	pass # Replace with function body.


func _process(_delta):
	position += Vector2(sin(Time.get_ticks_msec() / (3000.0*flash_multiplier)) * 0.3, cos(Time.get_ticks_msec() / (3000.0*flash_multiplier)) * 0.05)
	modulate.a = abs(sin(Time.get_ticks_msec() / (1000.0/flash_multiplier)))/3 + 0.33
