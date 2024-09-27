extends TileMapLayer

@export var map_width: int = 125
@export var map_height: int = 100
@export var noise: Noise

var world_size_in_pixels: Vector2i

var river_width: float = 3.0
var river_path_curve: Curve2D = Curve2D.new()

var terrain_dirt = 0
var terrain_water = 0

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
	
	Game.world_size = world_size_in_pixels * Vector2i(scale)

	await get_tree().tree_changed

	process_mode = ProcessMode.PROCESS_MODE_DISABLED

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

	var water_cells: Array[Vector2i] = []

	for x in range(width):
		for y in range(height):
			var value = noise.get_noise_2d(x, y)

			var cell_pos: Vector2i = Vector2i(x, y)
			if value > lerp(min_value, max_value, 0.6):
				water_cells.append(cell_pos)

	# Split water_cells into X chunks
	var chunk_amount = 20.0
	var chunk_size = ceil(float(water_cells.size()) / chunk_amount)
	var max_chunks = range(0, water_cells.size(), chunk_size)
	var index = 0
	for i in max_chunks:
		var chunk = water_cells.slice(i, i + chunk_size)
		set_cells_terrain_connect(chunk, 0, terrain_water)
		
		# Update the progress bar and allow UI to refresh
		index += 1
		loading.emit(index, max_chunks.size())

		await get_tree().process_frame

func create_wall(rect: Rect2) -> void:
	var wall = StaticBody2D.new()
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = rect.size / 2
	
	collider.shape = shape
	collider.position = rect.position + rect.size / 2
	
	wall.add_child(collider)

	# Make sure walls and player are on the same collision layer/mask
	wall.collision_layer = Utils.get_layer([1, 2, 3])
	wall.collision_mask = Utils.get_layer([1, 2, 3])

	wall.add_to_group("world border")

	wall.process_mode = ProcessMode.PROCESS_MODE_ALWAYS

	add_child(wall)
