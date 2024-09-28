extends CharacterBody2D

signal hurt(health: int, max_health: int)

@export var initial_health: int = 1
@export var health_per_minute: int = 1

@export var move_to_heal: int = 25

@onready var health = initial_health + floor(Game.get_elapsed_time() / 60.0) * health_per_minute
@onready var max_health = health

@onready var particles_scene = preload("res://scenes/particles/mob_kill.tscn")
@onready var healing_zone_scene = preload("res://scenes/entity/healing_zone.tscn")

var score_on_death: int = 500

var player

var healing_zone_instance

const SPEED_TOWARD_CAMPFIRE = 4000
const SPEED_TOWARD_ALLY = 6000
const DISTANCE_FROM_CAMPFIRE = 75

const xp_gain = 1

var move_target

signal moving
signal heal(healing_amount: int, max_health: int)

var casting_cooldown = 0.0

func _ready() -> void:
	healing_zone_instance = healing_zone_scene.instantiate()
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	casting_cooldown -= delta
	
	if health < max_health:
		add_to_group("hurt allied")
	else:
		remove_from_group("hurt allied")
	
	if not get_tree().get_nodes_in_group("hurt allied").is_empty() and casting_cooldown <= 0:
		move_target = _find_closest(get_tree().get_nodes_in_group("hurt allied"))
		
		if move_target.global_position.distance_to($".".global_position) > move_to_heal:
			velocity = position.direction_to(move_target.position) * delta * SPEED_TOWARD_ALLY
		else:
			velocity = Vector2(0, 0)
	elif not get_tree().get_nodes_in_group("campfire").is_empty():
		move_target = _find_closest(get_tree().get_nodes_in_group("campfire"))
		if move_target.global_position.distance_to($".".global_position) > DISTANCE_FROM_CAMPFIRE:
			velocity = position.direction_to(move_target.position) * delta * SPEED_TOWARD_CAMPFIRE
		else:
			velocity = Vector2(0, 0)
	if move_target:
		look_at(move_target.position)
	move_and_slide()

func _find_closest(group):
	var closest = group[0]
	for node in group:
		if node.global_position.distance_to($".".global_position) < closest.global_position.distance_to($".".global_position):
			closest = node
	return (closest)

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

func _on_heal(healing_amount, ally_max_health):
	if health < ally_max_health:
		health += healing_amount
