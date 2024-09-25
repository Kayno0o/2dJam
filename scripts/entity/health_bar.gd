extends TextureProgressBar

func _init() -> void:
	visible = false

func _on_curieux_hurt(health: int, max_health: int) -> void:
	max_value = max_health
	value = health
	visible = true
