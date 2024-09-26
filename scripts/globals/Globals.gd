extends Node

const COMMON_CARDS = ["res://scenes/upgradeCards/common/accelerationUp.tscn", "res://scenes/upgradeCards/common/damageUp.tscn", "res://scenes/upgradeCards/common/maxSpeed.tscn", "res://scenes/upgradeCards/common/momentumUp.tscn", "res://scenes/upgradeCards/common/rotationSpeedUp.tscn", "res://scenes/upgradeCards/common/sizeUp.tscn"]
const RARE_CARDS = ["res://scenes/upgradeCards/rare/accelerationUp.tscn", "res://scenes/upgradeCards/rare/damageUp.tscn", "res://scenes/upgradeCards/rare/maxSpeed.tscn", "res://scenes/upgradeCards/rare/momentumUp.tscn", "res://scenes/upgradeCards/rare/rotationSpeedUp.tscn", "res://scenes/upgradeCards/rare/sizeUp.tscn"]
const LEGENDARY_CARDS = ["res://scenes/upgradeCards/legendary/accelerationUp.tscn", "res://scenes/upgradeCards/legendary/damageUp.tscn", "res://scenes/upgradeCards/legendary/maxSpeed.tscn", "res://scenes/upgradeCards/legendary/momentumUp.tscn", "res://scenes/upgradeCards/legendary/rotationSpeedUp.tscn", "res://scenes/upgradeCards/legendary/sizeUp.tscn"]

signal ennemy_death

var world_size: Vector2i

var game_start_time: int = 0
var game_stop_time: int = 0

var score: int = 0
var high_score: int = 0

func init():
	score = 0
	set_game_start_time()

func set_game_start_time():
	game_stop_time = 0
	game_start_time = Time.get_ticks_msec()

# get elapsed time in seconds
func get_game_elapsed_time() -> float:
	if game_stop_time != 0:
		return game_stop_time / 1000.0
	return (Time.get_ticks_msec() - game_start_time) / 1000.0

func get_score() -> int:
	var value = int(get_game_elapsed_time() * 100) + score
	high_score = max(high_score, value)
	max(10, 10)
	return value

func get_layer(layers: Array[int]):
	var value: int = 0
	for layer in layers:
		value += int(pow(2, layer - 1))
	return value
