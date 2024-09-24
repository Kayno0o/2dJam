extends Node

const COMMON_CARDS = ["res://scenes/upgradeCards/common/accelerationUp.tscn", "res://scenes/upgradeCards/common/damageUp.tscn", "res://scenes/upgradeCards/common/maxSpeed.tscn", "res://scenes/upgradeCards/common/momentumUp.tscn", "res://scenes/upgradeCards/common/rotationSpeedUp.tscn", "res://scenes/upgradeCards/common/sizeUp.tscn"]
const RARE_CARDS = ["res://scenes/upgradeCards/rare/accelerationUp.tscn", "res://scenes/upgradeCards/rare/damageUp.tscn", "res://scenes/upgradeCards/rare/maxSpeed.tscn", "res://scenes/upgradeCards/rare/momentumUp.tscn", "res://scenes/upgradeCards/rare/rotationSpeedUp.tscn", "res://scenes/upgradeCards/rare/sizeUp.tscn"]
const LEGENDARY_CARDS = ["res://scenes/upgradeCards/legendary/accelerationUp.tscn", "res://scenes/upgradeCards/legendary/damageUp.tscn", "res://scenes/upgradeCards/legendary/maxSpeed.tscn", "res://scenes/upgradeCards/legendary/momentumUp.tscn", "res://scenes/upgradeCards/legendary/rotationSpeedUp.tscn", "res://scenes/upgradeCards/legendary/sizeUp.tscn"]

var worldSize: Vector2i

var ui_node: Control

var game_start_time: int = 0

func set_game_start_time():
	game_start_time = Time.get_ticks_msec()

# get elapsed time in seconds
func get_game_elapsed_time():
	return (Time.get_ticks_msec() - game_start_time) / 1000.0
