extends Control

@onready var resource_preloader: ResourcePreloader = $Loader/ResourcePreloader
@onready var player: CharacterBody2D = $Player
@onready var tilemap: TileMapLayer = $TileMapLayer

@onready var box_container: Node = $PropsContainer/Box
@onready var campfire_container: Node = $PropsContainer/Campfire

@onready var curieux_mob_container: Node = $MobContainer/Curieux
@onready var archer_mob_container: Node = $MobContainer/Archer
@onready var courageux_mob_container: Node = $MobContainer/Courageux
@onready var healer_mob_container: Node = $MobContainer/Healer

var last_second = 0

var curieux_limit = 12
var archer_limit = 4
var courageux_limit = 4
var healer_limit = 4

var mob_min_distance: int = 400
var mob_max_distance_init: int = 500
var mob_max_distance_over_time: int = 3000
var mob_max_distance_time: int = 60

func _init():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	Game.seconds += delta

	var new_second: int = int(floor(Game.seconds))

	# new second, spawn entities
	if last_second != new_second:
		spawn_curieux()

		if randf() < 0.25:
			spawn_healer()
		if randf() < 0.25:
			spawn_courageux()
		if randf() < 0.25:
			spawn_archer()

		# spawn boxes every 2 seconds
		if new_second % 2 == 0:
			spawn_box()

	last_second = new_second

func spawn_mob(mob_name: String, container: Node, limit: int):
	if container.get_child_count() > limit:
		return

	var new_mob: CharacterBody2D = resource_preloader.get_resource(mob_name).instantiate()

	new_mob.position = get_random_position()

	container.add_child(new_mob)

func spawn_curieux() -> void:
	spawn_mob("entity-curieux", curieux_mob_container, curieux_limit)

func spawn_healer() -> void:
	spawn_mob("entity-healer", healer_mob_container, healer_limit)

func spawn_archer() -> void:
	spawn_mob("entity-archer", archer_mob_container, archer_limit)

func spawn_courageux() -> void:
	spawn_mob("entity-courageux", courageux_mob_container, courageux_limit)

func spawn_box():
	var new_box = resource_preloader.get_resource("props-box").instantiate()
	new_box.position = get_random_world_position()
	box_container.add_child(new_box)

func spawn_campfire():
	var new_campfire = resource_preloader.get_resource("props-campfire").instantiate()
	new_campfire.position = get_random_world_position()
	campfire_container.add_child(new_campfire)

func get_random_world_position() -> Vector2:
	var rand_x = randi_range(0, Game.world_size.x)
	var rand_y = randi_range(0, Game.world_size.y)

	rand_x -= rand_x % Game.tile_size.x
	rand_y -= rand_y % Game.tile_size.y

	return Vector2(rand_x, rand_y)

func get_random_position() -> Vector2:
	# random angle between 0 and 2 * PI
	var angle = randf_range(0, TAU)

	# random distance between min and max
	var max_distance = max(
		lerp(mob_max_distance_init, mob_max_distance_over_time, Game.get_elapsed_time() / mob_max_distance_time),
		mob_max_distance_over_time
	)
	var distance = randf_range(mob_min_distance, max_distance)

	# get position based on player's position, angle, and distance
	var rand_x = player.position.x + cos(angle) * distance
	var rand_y = player.position.y + sin(angle) * distance

	# ensure the position stays within the world bounds
	rand_x = clamp(rand_x, 0, Game.world_size.x)
	rand_y = clamp(rand_y, 0, Game.world_size.y)

	return Vector2(rand_x, rand_y)

func _on_loading_screen_finish() -> void:
	Game.seconds = 0
	last_second = 0

	for i in range(10):
		spawn_curieux()
		spawn_campfire()

	process_mode = ProcessMode.PROCESS_MODE_INHERIT
