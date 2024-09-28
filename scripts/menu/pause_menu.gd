extends Control

func resume():
	visible = false
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	get_tree().paused = false

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	Globals.goto_scene("res://scenes/Game.tscn")

func _on_back_menu_pressed() -> void:
	resume()
	Globals.goto_scene("res://scenes/menu/main_menu.tscn")
