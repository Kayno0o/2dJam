extends Control

@onready var upgrade_card_container = $HBoxContainer


func _ready():
	Game.is_shop_open = true
	get_tree().paused = true

func _input(event):
	
	# check if mouse click on upgrade and select the one clicked on
	var mousePosition = get_global_mouse_position()
	
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		for node in upgrade_card_container.get_children():
			if node.get_global_rect().has_point(mousePosition):
				node.apply_upgrade()
				_quit()


func _quit():
	# unpause the game and free the upgrade screen
	get_tree().paused = false
	Game.is_shop_open = false
	queue_free()
