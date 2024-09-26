extends TextureProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = PlayerStats.xp
	max_value = PlayerStats.required_xp
