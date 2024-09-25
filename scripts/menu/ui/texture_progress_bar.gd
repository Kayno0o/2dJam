extends TextureProgressBar

func _process(delta):
	value = (PlayerStats.speed / PlayerStats.maxSpeed) * 100
