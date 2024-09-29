extends Control

@onready var button_one : AudioStreamPlayer = $Button1
@onready var button_two : AudioStreamPlayer = $Button2

func _on_start_button_pressed() -> void:
	if randi_range(0, 1) == 0 :
		button_one.play()
	else :
		button_two.play()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/credits.tscn")
