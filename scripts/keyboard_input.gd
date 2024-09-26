extends Control

func _input(event: InputEvent) -> void:
	# pauses when pressing P
	if event is InputEventKey:
		if event.keycode == 80 and event.is_pressed() == true:
			get_tree().paused = !get_tree().paused
