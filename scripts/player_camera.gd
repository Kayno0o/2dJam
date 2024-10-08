extends Camera2D

var initial_value: Vector2

func _ready() -> void:
	limit_right = Globals.world_size.x
	limit_bottom = Globals.world_size.y

	initial_value = zoom

func _process(delta: float) -> void:
	var targetValue = initial_value * lerp(1.0, 0.75, float(PlayerStats.speed) / float(PlayerStats.max_speed))
	zoom = lerp(zoom, targetValue, 5 * delta)
