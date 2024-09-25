extends Timer

var box = preload("res://scenes/props/box.tscn")

func _ready() -> void:
	wait_time = 2

func _on_timeout():
	var newBox = box.instantiate()

	var randX = randi_range(0, Globals.world_size.x)
	var randY = randi_range(0, Globals.world_size.y)

	newBox.position = Vector2(randX, randY)

	add_child(newBox)
