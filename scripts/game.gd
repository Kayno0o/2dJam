extends Control

@onready var resource_preloader: ResourcePreloader = $Loader/ResourcePreloader
@onready var player: CharacterBody2D = $Player
@onready var tilemap: TileMapLayer = $TileMapLayer

var last_second = 0

var curieux_min_distance: int = 400
var curieux_max_distance_init: int = 500
var curieux_max_distance_over_time: int = 3000
var curieux_max_distance_time: int = 60

func _init():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	Game.seconds += delta

	var new_second: int = int(floor(Game.seconds))

	# new second, spawn entities
	if last_second != new_second:
		spawn_curieux()

		# spawn boxes every 2 seconds
		if new_second % 2 == 0:
			spawn_box()

	last_second = new_second

func spawn_curieux() -> void:
	var new_curieux: CharacterBody2D = resource_preloader.get_resource("entity-curieux").instantiate()

	# random angle between 0 and 2 * PI
	var angle = randf_range(0, TAU)

	# random distance between min and max
	var max_distance = max(
		lerp(curieux_max_distance_init, curieux_max_distance_over_time, Game.get_elapsed_time() / curieux_max_distance_time),
		curieux_max_distance_over_time
	)
	var distance = randf_range(curieux_min_distance, max_distance)

	# get position based on player's position, angle, and distance
	var rand_x = player.position.x + cos(angle) * distance
	var rand_y = player.position.y + sin(angle) * distance

	# ensure the position stays within the world bounds
	rand_x = clamp(rand_x, 0, Game.world_size.x)
	rand_y = clamp(rand_y, 0, Game.world_size.y)

	new_curieux.position = Vector2(rand_x, rand_y)

	add_child(new_curieux)

func spawn_box():
	var new_box = resource_preloader.get_resource("props-box").instantiate()

	var rand_x = randi_range(0, Game.world_size.x)
	var rand_y = randi_range(0, Game.world_size.y)

	new_box.position = Vector2(rand_x, rand_y)

	add_child(new_box)


func _on_loading_screen_finish() -> void:
	Game.seconds = 0
	last_second = 0

	for i in range(10):
		spawn_curieux()

	process_mode = ProcessMode.PROCESS_MODE_INHERIT
