extends Control

func _ready() -> void:
	# set the score
	$ScoreLabel.text = "Score: " + str(Game.get_score())
	$HighScoreLabel.text = "High Score: " + str(Game.high_score)
	# set the time
	$TimeLabel.text = "Time: " + str(Game.get_elapsed_time()) + "s"


func _on_restart_pressed() -> void:
	Globals.goto_scene("res://scenes/Game.tscn")


func _on_go_to_menu_pressed() -> void:
	Globals.goto_scene("res://scenes/menu/MainMenu.tscn")
