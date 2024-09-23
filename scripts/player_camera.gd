extends Camera2D

@export var tilemap: TileMapLayer

var initialValue: Vector2

func _ready() -> void:
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	var worldSizeInPixels = mapRect.size * tileSize * Vector2i(tilemap.scale)
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y

	initialValue = zoom

func _process(delta: float) -> void:
	var targetValue = initialValue * lerp(1.0, 0.75, PlayerStats.speed / PlayerStats.maxSpeed)
	# zoom = lerp(zoom, targetValue, 5 * delta)
