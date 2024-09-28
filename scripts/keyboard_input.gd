extends Control

@onready var pause_menu: Control = $".." / UiCanvas / PauseMenu

func _input(event: InputEvent) -> void:
	# pauses when pressing P
	if event is InputEventKey:
		if event.keycode == 80 and event.is_pressed() == true and not Game.is_shop_open:
			toggle_pause()

func toggle_pause():
	var paused = !get_tree().paused
	get_tree().paused = paused
	Game.is_paused = paused
	if paused:
		pause()
	else:
		unpause()

func unpause():
	pause_menu.visible = false
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_DISABLED

func pause():
	pause_menu.visible = true
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
