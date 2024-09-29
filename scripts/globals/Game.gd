extends Node

signal ennemy_death

var resource_preloader: ResourcePreloader

var world_size: Vector2i
var tile_size: Vector2i

var is_shop_open = false
var is_paused = false

var seconds: float = 0

var score: int = 0
var high_score: int = 0

func increment_time():
	seconds += 1

# get elapsed time in seconds
func get_elapsed_time() -> float:
	return seconds

func get_score() -> int:
	var value = int(get_elapsed_time() * 100) + score
	high_score = max(high_score, value)
	return value

# mouse: 1 = left, 2 = right
var inputs: Array[int] = []

func reset_inputs():
	inputs.clear()

func get_input_axis() -> float:
	if inputs.is_empty():
		return 0.0
	if inputs[inputs.size() - 1] == 1:
		return -1.0
	return 1.0
