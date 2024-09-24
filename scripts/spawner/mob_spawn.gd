extends Timer

@export var player: CharacterBody2D

var enemy = preload("res://scenes/entity/Curieux.tscn")

func _ready():
	wait_time = .8
	start()

func _get_random_position() -> Vector2:
	var randX = randi_range(0, Globals.worldSize.x)
	var randY = randi_range(0, Globals.worldSize.y)

	return Vector2(randX, randY)

func _get_random_position_near_player(min_distance: int, max_distance: int) -> Vector2:
	# random angle between 0 and 2 * PI
	var angle = randf_range(0, TAU)

	# random distance between min and max
	var distance = randf_range(min_distance, max_distance)

	# get position based on player's position, angle, and distance
	var randX = player.position.x + cos(angle) * distance
	var randY = player.position.y + sin(angle) * distance

	# ensure the position stays within the world bounds
	randX = clamp(randX, 0, Globals.worldSize.x)
	randY = clamp(randY, 0, Globals.worldSize.y)

	return Vector2(randX, randY)


func _on_timeout() -> void:
	var newEnemy = enemy.instantiate()

	if Globals.get_game_elapsed_time() < 10:
		newEnemy.position = _get_random_position_near_player(400, lerp(500, 2000, Globals.get_game_elapsed_time() / 10))
	else:
		newEnemy.position = _get_random_position()

	add_child(newEnemy)
