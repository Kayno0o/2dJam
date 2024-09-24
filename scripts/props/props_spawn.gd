extends Timer

var box = preload("res://scenes/props/box.tscn")

func _ready() -> void:
	wait_time = 1
	start()

func _on_timeout():
	# Create a new enemy
	var newBox = box.instantiate()

	# Get a random position for the new enemy
	var randX = randi_range(0, Globals.worldSize.x)
	var randY = randi_range(0, Globals.worldSize.y)

	# Give him a position
	newBox.position = Vector2(randX, randY)

	# Spawn the enemy
	add_child(newBox)
