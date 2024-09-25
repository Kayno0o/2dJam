extends Node

enum raritys {COMMON, RARE, LEGENDARY}
enum upgrades {ADD_DAMAGE, ADD_MAX_SPEED, ADD_ACCELERATION, ADD_ROTATION_VELOCITY, ADD_VELOCITY_PERCENT, ADD_SIZE}

var damage: int
var speed: float
var max_speed: float
var acceleration: float
var velocity_percent: float

var rotation_velocity: float

var size: float

var level: int
var xp: int
var required_xp: float

func _init() -> void:
	damage = 1

	speed = 600.0
	max_speed = 1200.0
	acceleration = 75.0
	velocity_percent = 0.15

	rotation_velocity = 3

	size = 1.0

	level = 0
	xp = 0
	required_xp = 10.0

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
