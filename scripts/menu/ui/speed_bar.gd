extends TextureProgressBar

func _process(_delta: float):
	value = (PlayerStats.speed / PlayerStats.max_speed) * max_value
