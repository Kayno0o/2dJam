extends TileMapLayer

var world_size_in_pixels: Vector2i

func _ready() -> void:
	var map_rect = get_used_rect()
	var tile_size = tile_set.tile_size
	world_size_in_pixels = map_rect.size * tile_size
	
	# Create walls around the tilemap
	create_wall(Rect2(Vector2(0, -tile_size.y), Vector2(world_size_in_pixels.x, tile_size.y))) # Top
	create_wall(Rect2(Vector2(-tile_size.x, 0), Vector2(tile_size.x, world_size_in_pixels.y))) # Left
	create_wall(Rect2(Vector2(world_size_in_pixels.x, 0), Vector2(tile_size.x, world_size_in_pixels.y))) # Right
	create_wall(Rect2(Vector2(0, world_size_in_pixels.y), Vector2(world_size_in_pixels.x, tile_size.y))) # Bottom

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
