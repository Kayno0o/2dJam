extends TextureProgressBar

func _process(_delta):
	value = (PlayerStats.speed / PlayerStats.max_speed) * 100
