extends TileMapLayer

var world_size_in_pixels: Vector2i

@export var map_width: int = 75
@export var map_height: int = 75
@export var noise: Noise

var river_width: float = 3.0
var noise_scale: float = 0.75
var river_path_curve: Curve2D = Curve2D.new()

var terrain_dirt = 0
var terrain_water = 1
var terrain_grass = 2

func _ready() -> void:
	noise.seed = randi()
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
	
	Globals.worldSize = world_size_in_pixels * Vector2i(scale)

func generate_map(width: int, height: int):
	var grass_cells = []
	var water_cells = []
	
	for x in range(width):
		for y in range(height):
			var value = noise.get_noise_2d(x * noise_scale, y * noise_scale)
			var cell_pos = Vector2i(x, y)

			print(value)

			if value > 0.9:
				water_cells.append(cell_pos)
			else:
				grass_cells.append(cell_pos)
	
	set_cells_terrain_connect(water_cells, 0, terrain_water)
	set_cells_terrain_connect(grass_cells, 0, terrain_grass)

func create_wall(rect: Rect2) -> void:
	var wall = StaticBody2D.new()
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = rect.size / 2
	
	collider.shape = shape
	collider.position = rect.position + rect.size / 2
	
	wall.add_child(collider)

	# Make sure walls and player are on the same collision layer/mask
	wall.collision_layer = 1
	wall.collision_mask = 1

	wall.add_to_group("world border")

	add_child(wall)
