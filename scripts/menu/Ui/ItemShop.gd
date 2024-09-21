extends Control

@onready var upgradeCardContainer = $Background/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	position = PlayerStats.playerPos
	get_tree().paused = true
#	for node in upgradeCardContainer.get_children() :
#		node.upgrade_selected.connect(_quit)

func _input(event):
	var mousePosition = get_global_mouse_position()
	
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed() :
		for node in upgradeCardContainer.get_children():
			if node.get_global_rect().has_point(mousePosition) :
				node.apply_upgrade()
				_quit()


func _quit():
	get_tree().paused = false
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
