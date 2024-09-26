extends TileMapLayer

var world_size_in_pixels: Vector2i

@export var map_width: int = 75
@export var map_height: int = 75
@export var noise: Noise

var river_width: float = 3.0
var river_path_curve: Curve2D = Curve2D.new()

var terrain_dirt = 0
var terrain_water = 1
var terrain_grass = 2

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

	set_cells_terrain_connect(water_cells, 0, terrain_water)

func get_layer(layer: int) -> int:
	return int(pow(2, layer - 1))

func create_wall(rect: Rect2) -> void:
	var wall = StaticBody2D.new()
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = rect.size / 2
	
	collider.shape = shape
	collider.position = rect.position + rect.size / 2
	
	wall.add_child(collider)

	# Make sure walls and player are on the same collision layer/mask
	wall.collision_layer = get_layer(1) + get_layer(3)
	wall.collision_mask = get_layer(1) + get_layer(3)

	wall.add_to_group("world border")

	add_child(wall)
