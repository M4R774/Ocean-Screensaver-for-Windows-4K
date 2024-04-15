extends Node


func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    var primary_screen = DisplayServer.window_get_current_screen()
    var screen_count = DisplayServer.get_screen_count()
    print("Screen count: ", screen_count)
    print("Primary screen: ", primary_screen)
    for i in range(screen_count):
        if i == primary_screen:
            continue      
        var window: Window = Window.new()
        window.set_current_screen(i)
        var screen_position = DisplayServer.screen_get_position(i)
        window.set_position(screen_position)
        window.mode = Window.MODE_FULLSCREEN
        add_child(window)
        print("Window added to screen: ", i)
    get_window().grab_focus()


func _physics_process(_delta):
    get_window().grab_focus()
