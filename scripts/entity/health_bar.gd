extends TextureProgressBar

func _init() -> void:
	visible = false

func _on_curieux_hurt(health: int, max_health: int) -> void:
	max_value = max_health
	value = health
	visible = true


func _on_healing(healing_amount, max_health):
	max_value = max_health
	value += healing_amount
	if value == max_value :
		visible = false
