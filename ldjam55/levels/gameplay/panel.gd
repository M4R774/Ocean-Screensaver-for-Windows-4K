extends Panel

var is_hidden = false
var alpha = 1.0


func make_hidden():
    is_hidden = true


func _physics_process(_delta):
    if is_hidden:
        if alpha > 0.0:
            alpha -= 0.001
            self.modulate.a = alpha
        else:
            queue_free()
