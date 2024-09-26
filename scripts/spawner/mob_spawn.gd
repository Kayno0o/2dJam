extends Timer

@export var player: CharacterBody2D

@export var min_distance: int = 400
@export var max_distance_init: int = 500
@export var max_distance_over_time: int = 2000
@export var max_distance_time: int = 30

var enemy = preload("res://scenes/entity/Curieux.tscn")

func _ready():
	wait_time = 1

func _get_random_position() -> Vector2:
	var randX = randi_range(0, Globals.world_size.x)
	var randY = randi_range(0, Globals.world_size.y)

	return Vector2(randX, randY)

func _on_timeout() -> void:
	var new_enemy = enemy.instantiate()

	# random angle between 0 and 2 * PI
	var angle = randf_range(0, TAU)

	# random distance between min and max
	var distance = randf_range(min_distance, max(lerp(max_distance_init, max_distance_over_time, Globals.get_game_elapsed_time() / max_distance_time), max_distance_over_time))

	# get position based on player's position, angle, and distance
	var rand_x = player.position.x + cos(angle) * distance
	var rand_y = player.position.y + sin(angle) * distance

	# ensure the position stays within the world bounds
	rand_x = clamp(rand_x, 0, Globals.world_size.x)
	rand_y = clamp(rand_y, 0, Globals.world_size.y)

	new_enemy.position = Vector2(rand_x, rand_y)

	add_child(new_enemy)
