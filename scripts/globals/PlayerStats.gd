extends Node

enum raritys {COMMON, RARE, LEGENDARY}
enum upgrades {ADD_DAMAGE, ADD_MAX_SPEED, ADD_ACCELERATION, ADD_ROTATION_VELOCITY, ADD_FRICTION, ADD_SIZE}

var damage: int
var speed: float
var max_speed: float
var acceleration: float
var friction: float

var rotation_velocity: float

var size: float

var level: int
var xp: float
var required_xp: float

func accelerate(ratio: float):
	var min_ratio = PlayerStats.acceleration * ratio

	var acceleration_rate = 1
	if ratio < 0:
		acceleration_rate = min_ratio
	else:
		acceleration_rate = lerp(min_ratio * 1.5, min_ratio, PlayerStats.speed / PlayerStats.max_speed)
	PlayerStats.speed = clamp(PlayerStats.speed + acceleration_rate, 0, PlayerStats.max_speed)

func _init() -> void:
	damage = 1

	speed = 600.0
	max_speed = 800.0
	acceleration = 60.0
	friction = 0.13

	rotation_velocity = 3

	size = 1.0

	level = 0
	xp = 0.0
	required_xp = 5.0

func add_upgrades(upgrade, stats):
	if upgrade == upgrades.ADD_DAMAGE:
		damage += stats
		pass

	if upgrade == upgrades.ADD_MAX_SPEED:
		max_speed += stats
		pass

	if upgrade == upgrades.ADD_ACCELERATION:
		acceleration += stats
		pass

	if upgrade == upgrades.ADD_ROTATION_VELOCITY:
		rotation_velocity += stats
		pass
	
	if upgrade == upgrades.ADD_FRICTION:
		friction += stats
		pass
	
	if upgrade == upgrades.ADD_SIZE:
		size += stats
		pass
