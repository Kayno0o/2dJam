extends Camera2D

var initialValue: Vector2

func _ready() -> void:
	limit_right = Globals.worldSize.x
	limit_bottom = Globals.worldSize.y

	initialValue = zoom

func _process(delta: float) -> void:
	var targetValue = initialValue * lerp(1.0, 0.75, PlayerStats.speed / PlayerStats.maxSpeed)
	zoom = lerp(zoom, targetValue, 5 * delta)
