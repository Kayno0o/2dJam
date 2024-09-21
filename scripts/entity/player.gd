extends CharacterBody2D

var levelUpScene = preload("res://scenes/menu/ItemShop.tscn")

# speed lost when boucing on walls
var speedOnCollision = 50

var actualLevel = 0
var actualXp = 0
var levelUpXp = 10

var instance

var worldSizeInPixels: Vector2

@export var tilemap: TileMapLayer

func _ready() -> void:
	# set initial position
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	worldSizeInPixels = mapRect.size * tileSize * Vector2i(tilemap.scale)
	position = worldSizeInPixels / 2
	# set initial speed
	velocity = Vector2(PlayerStats.speed, 0)

func _input(event):
	#pauses when pressing P
	if event is InputEventKey :
		if event.keycode == 80 && event.is_pressed() == true:
			get_tree().paused = true

func _process(_delta: float) -> void:
	if actualXp >= levelUpXp:
		_level_up()

	if PlayerStats.speed < 0:
		queue_free()

func _level_up() :
	print("LEVEL UP")
	PlayerStats.playerPos = position
	instance = levelUpScene.instantiate()
	get_parent().add_child(instance)
	print(PlayerStats.damage)
	#Leveling up
	actualLevel += 1
	
	#Getting excess xp to the next level and reseting the xp
	actualXp -= levelUpXp
	
	#Make more Xp necessary to level up
	levelUpXp = levelUpXp + levelUpXp * 0.1


func _physics_process(delta: float) -> void:
	# rotate player depending on user input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		var angle = rotation_direction * PlayerStats.rotationVelocity * delta
		rotate(angle)
		velocity = velocity.rotated(angle)

	# bounce on walls on collision
	var collision = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		velocity = velocity.bounce(normal)
		rotation = velocity.angle()
		PlayerStats.speed -= speedOnCollision

	# lose speed over time
	var decay = PlayerStats.speed * PlayerStats.velocityPercent * delta
	var minSpeedDecay = PlayerStats.maxSpeed * 0.02 * delta
	PlayerStats.speed -= max(decay, minSpeedDecay)

	# limit speed to max speed
	PlayerStats.speed = min(PlayerStats.speed, PlayerStats.maxSpeed)

	# apply speed
	velocity = velocity.normalized() * PlayerStats.speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration, PlayerStats.maxSpeed)
		area.get_parent().HEALTH -= 1
