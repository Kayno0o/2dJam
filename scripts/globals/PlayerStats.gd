extends Node

enum raritys {COMMON, RARE, LEGENDARY}
enum upgrades {ADD_DAMAGE, ADD_MAX_SPEED, ADD_ACCELERATION, ADD_ROTATION_VELOCITY, ADD_VELOCITY_PERCENT, ADD_SIZE}

var damage = 1.0

var speed = 600.0
var max_speed = 1200.0

var acceleration = 75.0

var rotation_velocity = 3
var velocity_percent = 0.15

var size = 1.0

var level = 0
var xp = 0
var required_xp = 10

func add_upgrades(upgrade, stats):
	if upgrade == upgrades.ADD_DAMAGE:
		damage += stats
		pass

	if upgrade == upgrades.ADD_MAX_SPEED:
		max_speed *= 1 + (stats / 100)
		pass

	if upgrade == upgrades.ADD_ACCELERATION:
		acceleration *= 1 + (stats / 100)
		pass

	if upgrade == upgrades.ADD_ROTATION_VELOCITY:
		rotation_velocity += stats * 0.6
		pass
	
	if upgrade == upgrades.ADD_VELOCITY_PERCENT:
		velocity_percent -= stats / 100
		pass
	
	if upgrade == upgrades.ADD_SIZE:
		size += stats / 100
		pass
