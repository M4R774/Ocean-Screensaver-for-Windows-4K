extends Sprite2D

var MANAGER: GAME_MANAGER

var mana_timer: Timer


func _ready():
    MANAGER = get_node("/root/GAME_MANAGER_SINGLETON")
    add_timer_for_mana_generator()


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
