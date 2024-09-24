extends Control

const COMMON_CARDS = ["res://scenes/upgradeCards/common/accelerationUp.tscn", "res://scenes/upgradeCards/common/damageUp.tscn", "res://scenes/upgradeCards/common/maxSpeed.tscn", "res://scenes/upgradeCards/common/momentumUp.tscn", "res://scenes/upgradeCards/common/rotationSpeedUp.tscn", "res://scenes/upgradeCards/common/sizeUp.tscn"]
const RARE_CARDS = ["res://scenes/upgradeCards/rare/accelerationUp.tscn", "res://scenes/upgradeCards/rare/damageUp.tscn", "res://scenes/upgradeCards/rare/maxSpeed.tscn", "res://scenes/upgradeCards/rare/momentumUp.tscn", "res://scenes/upgradeCards/rare/rotationSpeedUp.tscn", "res://scenes/upgradeCards/rare/sizeUp.tscn"]
const LEGENDARY_CARDS = ["res://scenes/upgradeCards/legendary/accelerationUp.tscn", "res://scenes/upgradeCards/legendary/damageUp.tscn", "res://scenes/upgradeCards/legendary/maxSpeed.tscn", "res://scenes/upgradeCards/legendary/momentumUp.tscn", "res://scenes/upgradeCards/legendary/rotationSpeedUp.tscn", "res://scenes/upgradeCards/legendary/sizeUp.tscn"]

var cameraPos: Vector2

var worldSize: Vector2i
