extends TileMapLayer

var world_size_in_pixels: Vector2i

@export var map_width: int = 125
@export var map_height: int = 100
@export var noise: Noise

var river_width: float = 3.0
var river_path_curve: Curve2D = Curve2D.new()

var terrain_dirt = 0
var terrain_water = 1
var terrain_grass = 2

signal loading(loading_value: int, loading_max_value: int)

func _ready() -> void:
	generate_map(map_width, map_height)

	# get world size
	var map_rect = get_used_rect()
	var tile_size = tile_set.tile_size
	world_size_in_pixels = map_rect.size * tile_size
	
	# Create walls around the tilemap
	create_wall(Rect2(Vector2(0, -tile_size.y), Vector2(world_size_in_pixels.x, tile_size.y))) # Top
	create_wall(Rect2(Vector2(-tile_size.x, 0), Vector2(tile_size.x, world_size_in_pixels.y))) # Left
	create_wall(Rect2(Vector2(world_size_in_pixels.x, 0), Vector2(tile_size.x, world_size_in_pixels.y))) # Right
	create_wall(Rect2(Vector2(0, world_size_in_pixels.y), Vector2(world_size_in_pixels.x, tile_size.y))) # Bottom
	
	Globals.world_size = world_size_in_pixels * Vector2i(scale)

func generate_map(width: int, height: int):
	noise.seed = randi()

	var max_value = -INF
	var min_value = INF

	var grass_tileset = tile_set.get_source(2)
	var grass_tile_count = grass_tileset.get_tiles_count()
	
	# get min/max values
	for x in range(width):
		for y in range(height):
			var value = noise.get_noise_2d(x, y)

			max_value = max(max_value, value)
			min_value = min(min_value, value)

			set_cell(Vector2i(x, y), 2, grass_tileset.get_tile_id(randi_range(0, grass_tile_count - 1)))

	var water_cells = []

	for x in range(width):
		for y in range(height):
			var value = noise.get_noise_2d(x, y)

			var cell_pos = Vector2i(x, y)
			if value > lerp(min_value, max_value, 0.6):
				water_cells.append(cell_pos)

	get_tree().paused = true

	# Split water_cells into 10 chunks
	var chunk_size = ceil(float(water_cells.size()) / 10)
	var max_chunks = range(0, water_cells.size(), chunk_size)
	var index = 0
	for i in max_chunks:
		var chunk = water_cells.slice(i, chunk_size)
		set_cells_terrain_connect(chunk, 0, terrain_water)
		
		# Update the progress bar and allow UI to refresh
		index += 1
		# print_debug(index, " - ", max_chunks.size())
		loading.emit(index, max_chunks.size())
		await get_tree().create_timer(.1).timeout
		await get_tree().process_frame

	get_tree().paused = false
	Globals.init()

func create_wall(rect: Rect2) -> void:
	var wall = StaticBody2D.new()
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = rect.size / 2
	
	collider.shape = shape
	collider.position = rect.position + rect.size / 2
	
	wall.add_child(collider)

	# Make sure walls and player are on the same collision layer/mask
	wall.collision_layer = Globals.get_layer([1, 2, 3])
	wall.collision_mask = Globals.get_layer([1, 2, 3])

	wall.add_to_group("world border")

	add_child(wall)
