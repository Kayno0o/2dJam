extends CharacterBody2D

@export var progress_bar: TextureProgressBar

var particles_scene = preload("res://scenes/particles/mob_kill.tscn")

var player
var max_health = 1.0
var health = 1.0

const SPEED = 5000
const MAX_DISTANCE = 250
const MIN_DISTANCE = 200

const xp_gain = 1

var is_move_toward = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

	health = 1 + floor(Globals.get_game_elapsed_time() / 25.0)
	max_health = health

	progress_bar.visible = false

func _physics_process(delta: float) -> void:
	# make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > MAX_DISTANCE:
		is_move_toward = true
	# make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < MIN_DISTANCE:
		is_move_toward = false

	if is_move_toward:
		velocity = position.direction_to(player.position) * delta * SPEED
	else:
		velocity = -position.direction_to(player.position) * delta * SPEED

	move_and_slide()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		health -= PlayerStats.damage

		progress_bar.max_value = max_health
		progress_bar.value = health
		progress_bar.visible = true

		var particles: GPUParticles2D = particles_scene.instantiate()
		particles.position = position

		get_parent().add_child(particles)
		particles.emitting = true

		if health <= 0:
			PlayerStats.xp += xp_gain
			PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration, PlayerStats.max_speed)

			queue_free()
