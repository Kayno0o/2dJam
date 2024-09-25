extends CharacterBody2D

var particles_scene = preload("res://scenes/particles/mob_kill.tscn")

var player
var health = 1.0

const SPEED = 5000
const MAX_DISTANCE = 250
const MIN_DISTANCE = 200

const xpGain = 1

var moveToward = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health = 1 + floor(Globals.get_game_elapsed_time() / 25.0)

func _physics_process(delta: float) -> void:
	# make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > MAX_DISTANCE:
		moveToward = true
	# make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < MIN_DISTANCE:
		moveToward = false

	if moveToward:
		velocity = position.direction_to(player.position) * delta * SPEED
	else:
		velocity = -position.direction_to(player.position) * delta * SPEED

	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Area2D && area.get_parent().is_in_group("player"):
		health -= PlayerStats.damage

		if health <= 0:
			PlayerStats.xp += xpGain
			PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration, PlayerStats.maxSpeed)

			var particles: GPUParticles2D = particles_scene.instantiate()
			particles.position = position

			get_parent().add_child(particles)
			particles.emitting = true

			queue_free()
