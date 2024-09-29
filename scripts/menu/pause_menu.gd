extends Control

@onready var button_one : AudioStreamPlayer = $"../../Button1"
@onready var button_two : AudioStreamPlayer = $"../../Button2"
@onready var main_theme : AudioStreamPlayer = $"../../MainTheme"

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

func _on_music_on_button_down():
	main_theme.stream_paused = true
	$VBoxContainer2/MusicOn.visible = false
	$VBoxContainer2/MusicOff.visible = true

func _on_music_off_button_down():
	main_theme.stream_paused = false
	$VBoxContainer2/MusicOn.visible = true
	$VBoxContainer2/MusicOff.visible = false
