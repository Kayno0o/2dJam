extends Control


@onready var progress_bar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = 5
	progress_bar.max_value = 15


func _on_tile_map_layer_loading(loading_value: int, loading_max_value: int) -> void:
	print_debug(loading_value, " - ", loading_max_value)
	progress_bar.value = loading_value
	progress_bar.max_value = loading_max_value

	if loading_value == loading_max_value:
		visible = false
