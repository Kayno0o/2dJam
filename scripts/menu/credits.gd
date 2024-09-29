extends Control

@onready var button_one : AudioStreamPlayer = $Button1
@onready var button_two : AudioStreamPlayer = $Button2

func _ready():
	if randi_range(0, 1) == 0 :
		button_one.play()
	else :
		button_two.play()

func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
