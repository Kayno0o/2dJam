extends CharacterBody2D

var speed = 500
var maxSpeed = 1500

var acceleration = 100

var rotationVelocity = 3
var velocityPercent = 0.10

var worldSizeInPixels: Vector2

@export var tilemap: TileMapLayer

func _ready() -> void:
	# set initial position
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	worldSizeInPixels = mapRect.size * tileSize * Vector2i(tilemap.scale)
	position = worldSizeInPixels / 2
	# set initial speed
	velocity = Vector2(speed, 0)

func _process(_delta: float) -> void:
	if speed < 0:
		queue_free()

func _physics_process(delta: float) -> void:
	# rotate player depending on user input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		var angle = rotation_direction * rotationVelocity * delta
		rotate(angle)
		velocity = velocity.rotated(angle)

	# bounce on walls on collision
	var collision = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		velocity = velocity.bounce(normal)
		rotation = velocity.angle()

	# lose speed over time
	var decay = speed * velocityPercent * delta
	var minSpeedDecay = maxSpeed * 0.02 * delta
	speed -= max(decay, minSpeedDecay)

	# apply speed
	velocity = velocity.normalized() * speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		speed = min(speed + acceleration, maxSpeed)
		area.get_parent().HEALTH -= 1
