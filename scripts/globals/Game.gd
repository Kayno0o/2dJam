extends Node

signal ennemy_death

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
