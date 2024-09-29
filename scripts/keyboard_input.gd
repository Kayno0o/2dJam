extends Control

@onready var pause_menu: Control = $".." / UiCanvas / PauseMenu

func _input(event: InputEvent) -> void:
	# pauses when pressing P
	if event is InputEventKey and event.is_pressed():
		if (event.keycode == KEY_P or event.keycode == KEY_ESCAPE) and not Game.is_shop_open:
			toggle_pause()

	# PLAYER MOVEMENT

	# Handle click on left/right of the screen
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		var screen_width = get_viewport().get_visible_rect().size.x
		var mouse_x = event.position.x
		if event.is_pressed():
			if mouse_x < screen_width / 2:
				Game.inputs.erase(1)
				Game.inputs.append(1)
			else:
				Game.inputs.erase(2)
				Game.inputs.append(2)
		else:
			if mouse_x < screen_width / 2:
				Game.inputs.erase(1)
			else:
				Game.inputs.erase(2)

	# Handle left/right arrow keys
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_LEFT:
				Game.inputs.erase(1)
				Game.inputs.append(1)
			elif event.keycode == KEY_RIGHT:
				Game.inputs.erase(2)
				Game.inputs.append(2)
		else:
			if event.keycode == KEY_LEFT:
				Game.inputs.erase(1)
			elif event.keycode == KEY_RIGHT:
				Game.inputs.erase(2)

func toggle_pause():
	var paused = !get_tree().paused
	get_tree().paused = paused
	Game.is_paused = paused
	if paused:
		pause()
		Game.reset_inputs()
	else:
		unpause()

func unpause():
	pause_menu.visible = false
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_DISABLED

func pause():
	pause_menu.visible = true
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
