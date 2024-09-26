extends Control

func _ready() -> void:
	# set the score
	$ScoreLabel.text = "Score: " + str(Globals.get_score())
	$HighScoreLabel.text = "High Score: " + str(Globals.high_score)
	# set the time
	$TimeLabel.text = "Time: " + str(Globals.get_game_elapsed_time()) + "s"

	$Restart.connect("pressed", _on_restart_pressed)
	$GoToMenu.connect("pressed", _on_go_to_menu_pressed)


func _on_restart_pressed() -> void:
	print("_on_restart_pressed")
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_go_to_menu_pressed() -> void:
	print("_on_go_to_menu_pressed")
	get_tree().change_scene_to_file("res://scenes/menu/MainMenu.tscn")
