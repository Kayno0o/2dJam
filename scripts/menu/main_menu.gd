extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/credits.tscn")
