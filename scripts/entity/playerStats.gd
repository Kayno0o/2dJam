extends Node

enum raritys {COMMON, RARE, LEGENDARY}
enum upgrades {ADD_DAMAGE, ADD_SPEED, ADD_MAX_SPEED, ADD_ACCELERATION, ADD_ROTATION_VELOCITY, ADD_VELOCITY_PERCENT}

var playerPos : Vector2

var damage = 1.0

var speed = 15_000
var maxSpeed = 150_000

var acceleration = 10_000

var rotationVelocity = .05
var velocityPercent = 0.10

func add_upgrades(upgrade, stats) :
	if upgrade == upgrades.ADD_DAMAGE :
		damage += stats
	elif upgrade == upgrades.ADD_SPEED :
		speed += speed * (stats / 100)
	elif upgrade == upgrades.ADD_MAX_SPEED :
		maxSpeed += maxSpeed * (stats / 100)
	elif upgrade == upgrades.ADD_ACCELERATION :
		acceleration += acceleration * (stats / 100)
	elif upgrade == upgrades.ADD_ROTATION_VELOCITY :
		rotationVelocity += stats / 100
	elif upgrade == upgrades.ADD_VELOCITY_PERCENT :
		velocityPercent -= stats / 100
	pass
