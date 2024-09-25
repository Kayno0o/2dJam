extends CharacterBody2D

var levelUpScene = preload("res://scenes/menu/UpgradeMenu.tscn")

var instance

var worldSizeInPixels: Vector2

@export var movementParticles: GPUParticles2D

func _ready() -> void:
	# set initial position
	position = Globals.worldSize / 2
	
	# set initial speed
	velocity = Vector2(PlayerStats.speed, 0)

func _process(_delta: float) -> void:
	# check if you need to level up
	if PlayerStats.xp >= PlayerStats.requiredXp:
		_level_up()

	# check if you need to die, skill issue
	if PlayerStats.speed < 0:
		queue_free()

	var particleMaterial: ParticleProcessMaterial = movementParticles.process_material
	if particleMaterial is ParticleProcessMaterial:
		# spread goes from 1 to 90 degrees, depending on the speed compared to max speed
		particleMaterial.spread = lerp(90.0, 5.0, float(PlayerStats.speed) / float(PlayerStats.maxSpeed))
		particleMaterial.scale_max = lerp(1.0, 3.5, float(PlayerStats.speed) / float(PlayerStats.maxSpeed))

		# Calculate the normalized direction vector once
		var normalized_velocity = velocity.normalized()
		var particle_direction = Vector3(abs(velocity.x), 0, 0)

		# direction for the particles is the opposite of the velocity
		particleMaterial.direction = particle_direction
		particleMaterial.initial_velocity_min = PlayerStats.speed / 8
		particleMaterial.initial_velocity_max = PlayerStats.speed / 3

		# make the particle spawn a bit behind
		particleMaterial.emission_shape_offset = Vector3(abs(normalized_velocity.x) * -32, 0, 0)

func _level_up():
	# show level up menu
	Globals.ui_node.add_child(levelUpScene.instantiate())

	# leveling up, getting excess xp to the next level and reseting the xp then make more Xp necessary to level up
	PlayerStats.level += 1
	PlayerStats.xp -= PlayerStats.requiredXp
	PlayerStats.requiredXp *= 1.15

func _physics_process(delta: float) -> void:
	
	# Modifying player size
	scale = Vector2(PlayerStats.size, PlayerStats.size)
	
	
	# rotate player depending on user input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		var angle = rotation_direction * PlayerStats.rotationVelocity * delta
		rotate(angle)
		velocity = velocity.rotated(angle)

	# bounce on walls on collision
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		var collider: Node2D = collision.get_collider()
		if collider is Node2D and collider.is_in_group("world border"):
			velocity = velocity.bounce(normal)
			rotation = velocity.angle()
			PlayerStats.speed -= PlayerStats.acceleration

	# lose speed over time
	var decay = PlayerStats.speed * PlayerStats.velocityPercent * delta
	var minSpeedDecay = PlayerStats.maxSpeed * 0.02 * delta
	PlayerStats.speed -= max(decay, minSpeedDecay)

	# limit speed to max speed
	PlayerStats.speed = min(PlayerStats.speed, PlayerStats.maxSpeed)

	# apply speed
	velocity = velocity.normalized() * PlayerStats.speed
