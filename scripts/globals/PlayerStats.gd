extends Node

enum raritys {COMMON, RARE, LEGENDARY}
enum upgrades {ADD_DAMAGE, ADD_MAX_SPEED, ADD_ACCELERATION, ADD_ROTATION_VELOCITY, ADD_VELOCITY_PERCENT, ADD_SIZE}

var playerPos : Vector2

var damage = 1.0

var speed = 500
var maxSpeed = 1500

var acceleration = 100

var rotationVelocity = 3
var velocityPercent = 0.10

var size = 1.0

func add_upgrades(upgrade, stats) :
	if upgrade == upgrades.ADD_DAMAGE :
		damage += stats
		pass

	if upgrade == upgrades.ADD_MAX_SPEED :
		maxSpeed *= 1 + (stats / 100)
		pass

	if upgrade == upgrades.ADD_ACCELERATION :
		acceleration *= 1 + (stats / 100)
		pass

	if upgrade == upgrades.ADD_ROTATION_VELOCITY :
		rotationVelocity += stats * 0.6
		pass
	
	if upgrade == upgrades.ADD_VELOCITY_PERCENT :
		velocityPercent -= stats / 100
		pass
	
	if upgrade == upgrades.ADD_SIZE :
		size += stats / 100
		pass
