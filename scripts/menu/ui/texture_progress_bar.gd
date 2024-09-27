extends TextureProgressBar

func _process(delta: float):
	value = lerp(value, (PlayerStats.speed / PlayerStats.max_speed) * max_value, 5 * delta)
