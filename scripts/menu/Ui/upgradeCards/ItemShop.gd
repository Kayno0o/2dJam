extends Control

@onready var upgradeCardContainer = $Background/HBoxContainer


func _ready():
	
	# set the upgrade screen position and pause the game
	position = Globals.cameraPos
	get_tree().paused = true

func _input(event):
	
	# check if mouse click on upgrade and select the one clicked on
	var mousePosition = get_global_mouse_position()
	
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed() :
		for node in upgradeCardContainer.get_children():
			if node.get_global_rect().has_point(mousePosition) :
				node.apply_upgrade()
				_quit()


func _quit():
	# unpause the game and free the upgrade screen
	get_tree().paused = false
	queue_free()
