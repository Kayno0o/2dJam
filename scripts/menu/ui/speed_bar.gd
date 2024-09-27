extends TextureProgressBar

func _process(delta: float):
	max_value = 1000
	value = lerp(value, (PlayerStats.speed / PlayerStats.max_speed) * max_value, 15 * delta)
