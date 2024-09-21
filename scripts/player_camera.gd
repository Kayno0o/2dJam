extends Camera2D

@export var tilemap: TileMapLayer

func _ready() -> void:
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	var worldSizeInPixels = mapRect.size * tileSize * Vector2i(tilemap.scale)
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
