extends CharacterBody2D

signal hurt(health: int, max_health: int)

@export var initial_health: int = 1
@export var health_per_minute: int = 1

@onready var health = initial_health + floor(Game.get_elapsed_time() / 60.0) * health_per_minute
@onready var max_health = health

@onready var particles_scene = preload("res://scenes/particles/mob_kill.tscn")
@onready var arrow_scene = preload("res://scenes/entity/Arrow.tscn")

var score_on_death: int = 500

var player

const SPEED_TOWARD = 4000
const SPEED_AWAY = 6000
const DISTANCE_MOVE_TOWARD = 500
const DISTANCE_MOVE_AWAY = 300

const xp_gain = 1

var is_move_toward = false
var cooldown = 2.0

signal moving
signal shooting

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	cooldown -= delta
	look_at(player.position)
	
	# make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > DISTANCE_MOVE_TOWARD:
		moving.emit()
		is_move_toward = true
	# make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < DISTANCE_MOVE_AWAY:
		shooting.emit()
		is_move_toward = false

	if is_move_toward:
		velocity = position.direction_to(player.position) * delta * SPEED_TOWARD
	elif cooldown <= 0 and is_move_toward == false:
		_shoot()
		velocity = Vector2(0,0)

	move_and_slide()

func _shoot() :
	var arrow : CharacterBody2D = arrow_scene.instantiate()
	arrow.global_position = $Bow.global_position
	cooldown = 2.0
	shooting.emit()
	get_tree().current_scene.add_child(arrow)

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
			PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration, PlayerStats.max_speed)
			Game.score += score_on_death

			queue_free()
