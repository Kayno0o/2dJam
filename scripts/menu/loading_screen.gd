extends Control

@onready var progress_bar = $TextureProgressBar

signal finish

func _on_load(loading_value: int, loading_max_value: int) -> void:
	progress_bar.value = loading_value
	progress_bar.max_value = loading_max_value

	if loading_value == loading_max_value:
		visible = false
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		finish.emit()
