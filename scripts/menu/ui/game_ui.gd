extends Control

var levelUpScene = preload("res://scenes/menu/UpgradeMenu.tscn")

func _on_player_level_up() -> void:
	# show level up menu
	add_child(levelUpScene.instantiate())
	Game.reset_inputs()

	# leveling up, getting excess xp to the next level and reseting the xp then make more Xp necessary to level up
	PlayerStats.level += 1
	PlayerStats.xp -= PlayerStats.required_xp
	PlayerStats.required_xp *= 1.15
