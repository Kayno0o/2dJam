extends CharacterBody2D

var levelUpScene = preload("res://scenes/menu/UpgradeMenu.tscn")

@export var movement_particles: GPUParticles2D

var was_last_move_collision = false

func _ready() -> void:
	# set initial position
	position = Globals.world_size / 2
	
	# set initial speed
	velocity = Vector2(PlayerStats.speed, 0)

func _process(_delta: float) -> void:
	# check if you need to level up
	if PlayerStats.xp >= PlayerStats.required_xp:
		_level_up()

	# check if you need to die, skill issue
	if PlayerStats.speed < 0:
		queue_free()

	var particle_material: ParticleProcessMaterial = movement_particles.process_material
	if particle_material is ParticleProcessMaterial:
		# spread goes from 1 to 90 degrees, depending on the speed compared to max speed
		particle_material.spread = lerp(90.0, 5.0, float(PlayerStats.speed) / float(PlayerStats.max_speed))
		particle_material.scale_max = lerp(1.0, 3.5, float(PlayerStats.speed) / float(PlayerStats.max_speed))

		# Calculate the normalized direction vector once
		var normalized_velocity = velocity.normalized()
		var particle_direction = Vector3(abs(velocity.x), 0, 0)

		# direction for the particles is the opposite of the velocity
		particle_material.direction = particle_direction
		particle_material.initial_velocity_min = PlayerStats.speed / 8
		particle_material.initial_velocity_max = PlayerStats.speed / 3

		# make the particle spawn a bit behind
		particle_material.emission_shape_offset = Vector3(abs(normalized_velocity.x) * -32, 0, 0)

func _level_up():
	# show level up menu
	Globals.ui_node.add_child(levelUpScene.instantiate())

	# leveling up, getting excess xp to the next level and reseting the xp then make more Xp necessary to level up
	PlayerStats.level += 1
	PlayerStats.xp -= PlayerStats.required_xp
	PlayerStats.required_xp *= 1.15

func _physics_process(delta: float) -> void:
	# update player size
	scale = Vector2(PlayerStats.size, PlayerStats.size)

	# rotate player depending on user input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		var angle = rotation_direction * PlayerStats.rotation_velocity * delta
		rotate(angle)
		velocity = velocity.rotated(angle)

	# bounce on walls on collision
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and not was_last_move_collision:
		was_last_move_collision = true
		var normal = collision.get_normal()
		var collider: Node2D = collision.get_collider()

		if collider is Node2D and collider.is_in_group("world border"):
			velocity = velocity.bounce(normal)
			rotation = velocity.angle()
			PlayerStats.speed -= PlayerStats.acceleration
	else:
		was_last_move_collision = false

	# lose speed over time
	var decay = PlayerStats.speed * PlayerStats.velocity_percent * delta
	var minSpeedDecay = PlayerStats.max_speed * 0.02 * delta
	PlayerStats.speed -= max(decay, minSpeedDecay)

	# limit speed to max speed
	PlayerStats.speed = min(PlayerStats.speed, PlayerStats.max_speed)

	# apply speed
	velocity = velocity.normalized() * PlayerStats.speed
