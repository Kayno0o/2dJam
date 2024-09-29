extends Control

@onready var button_one : AudioStreamPlayer = $"../../Button1"
@onready var button_two : AudioStreamPlayer = $"../../Button2"

func resume():
	if randi_range(0, 1) == 0 :
		button_one.play()
	else :
		button_two.play()
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
