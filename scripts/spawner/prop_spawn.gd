extends Timer

var box = preload("res://scenes/props/box.tscn")

func _ready() -> void:
	wait_time = 1.4
	start()

func _on_timeout():
	var newBox = box.instantiate()

	var randX = randi_range(0, Globals.worldSize.x)
	var randY = randi_range(0, Globals.worldSize.y)

	newBox.position = Vector2(randX, randY)

	add_child(newBox)
