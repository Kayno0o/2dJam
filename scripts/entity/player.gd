extends CharacterBody2D

@export var movement_particles: GPUParticles2D

@onready var bounce_sound: AudioStreamPlayer = $"../WallBounce"

signal level_up

func _ready() -> void:
	PlayerStats._init()

	# set initial position
	position = Game.world_size / 2
	
	# set initial speed
	velocity = Vector2(PlayerStats.speed, 0)

# mouse: 1 = left, 2 = right
var inputs: Array[int] = []

func _input(event):
	# Handle click on left/right of the screen
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		var screen_width = get_viewport().get_visible_rect().size.x
		var mouse_x = event.position.x
		if event.is_pressed():
			if mouse_x < screen_width / 2:
				inputs.erase(1)
				inputs.append(1)
			else:
				inputs.erase(2)
				inputs.append(2)
		else:
			if mouse_x < screen_width / 2:
				inputs.erase(1)
			else:
				inputs.erase(2)

	# Handle left/right arrow keys
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_LEFT:
				inputs.erase(1)
				inputs.append(1)
			elif event.keycode == KEY_RIGHT:
				inputs.erase(2)
				inputs.append(2)
		else:
			if event.keycode == KEY_LEFT:
				inputs.erase(1)
			elif event.keycode == KEY_RIGHT:
				inputs.erase(2)

func get_input_axis() -> float:
	if inputs.is_empty():
		return 0.0
	if inputs[inputs.size() - 1] == 1:
		return -1.0
	return 1.0

func _process(_delta: float) -> void:
	# check if you need to level up
	if PlayerStats.xp >= PlayerStats.required_xp:
		level_up.emit()

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

	# check if you need to die, skill issue
	if PlayerStats.speed < 0:
		Globals.goto_scene("res://scenes/menu/game_over.tscn")

func _physics_process(delta: float) -> void:
	# update player size
	scale = Vector2(PlayerStats.size, PlayerStats.size)

	# rotate player depending on user input
	var input_axis = get_input_axis()
	if input_axis:
		var angle = input_axis * PlayerStats.rotation_velocity * delta
		rotate(angle)
		velocity = velocity.rotated(angle)

	# bounce on walls on collision
	var movement: Vector2 = velocity * delta
	var collision: KinematicCollision2D = move_and_collide(movement)
	if collision:
		var normal = collision.get_normal()
		var collider: Node2D = collision.get_collider()

		if collider is Node2D and collider.is_in_group("world border"):
			bounce_sound.play()
			move_and_collide(-movement)
			velocity = velocity.bounce(normal)
			rotation = velocity.angle()
			PlayerStats.speed -= PlayerStats.acceleration

	# lose speed over time
	# var decay = PlayerStats.speed * PlayerStats.friction * delta
	# var minSpeedDecay = PlayerStats.max_speed * 0.04 * delta
	# PlayerStats.speed -= max(decay, minSpeedDecay)

	PlayerStats.speed -= PlayerStats.acceleration * PlayerStats.friction * 4 * delta

	# limit speed to max speed
	PlayerStats.speed = min(PlayerStats.speed, PlayerStats.max_speed)

	# apply speed
	velocity = velocity.normalized() * PlayerStats.speed
