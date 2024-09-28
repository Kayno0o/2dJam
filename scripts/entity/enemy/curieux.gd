extends CharacterBody2D

signal hurt(health: int, max_health: int)

@export var initial_health: int = 1
@export var health_per_minute: int = 1

@onready var health = initial_health + floor(Game.get_elapsed_time() / 60.0) * health_per_minute
@onready var max_health = health

@onready var particles_scene = Game.resource_preloader.get_resource("particles-mob_kill")

var score_on_death: int = 500

var acceleration_mult = 1

var player

const SPEED_TOWARD = 4000
const SPEED_AWAY = 6000
const DISTANCE_MOVE_TOWARD = 600
const DISTANCE_MOVE_AWAY = 200

const xp_gain = 1

var is_move_toward = false

signal moving
signal scared
signal heal(healing_amount: int, max_health: int)

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	$SpriteController.look_at(player.position)
	
	if health < max_health:
		add_to_group("hurt allied")
	else:
		remove_from_group("hurt allied")
	
	# make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > DISTANCE_MOVE_TOWARD:
		moving.emit()
		is_move_toward = true
	# make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < DISTANCE_MOVE_AWAY:
		scared.emit()
		is_move_toward = false

	if is_move_toward:
		velocity = position.direction_to(player.position) * delta * SPEED_TOWARD
	else:
		velocity = -position.direction_to(player.position) * delta * SPEED_AWAY

	move_and_slide()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		health -= PlayerStats.damage

		hurt.emit(health, max_health)

		var particles: GPUParticles2D = particles_scene.instantiate()
		particles.position = position

		get_parent().add_child(particles)
		particles.emitting = true

		if health <= 0:
			Game.ennemy_death.emit()
			PlayerStats.xp += xp_gain
			PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration * acceleration_mult, PlayerStats.max_speed)
			Game.score += score_on_death

			queue_free()


func _on_heal(healing_amount, max_health):
	if health < max_health:
		health += healing_amount
