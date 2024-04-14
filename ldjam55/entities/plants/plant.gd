extends Node2D

var MANAGER: GAME_MANAGER

var mana_timer: Timer
var alpha = 0.0


func _ready():
	self.modulate.a = 0.0
	MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
	add_timer_for_mana_generator()


func _process(_delta):
	if self.is_visible():
		if alpha < 1.0:
			alpha += 0.001
			self.modulate.a = alpha


func add_timer_for_mana_generator():
	mana_timer = Timer.new()
	add_child(mana_timer)
	mana_timer.set_wait_time(1)
	mana_timer.set_one_shot(false)
	mana_timer.connect("timeout", self._on_timer_timeout)
	mana_timer.start()


func _on_timer_timeout() -> void:
	if self.is_visible():
		MANAGER.add_mana(1)


func make_visible():
	self.show()
