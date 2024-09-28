extends CharacterBody2D

@export var initial_health: int = 1
@export var health_per_minute: int = 1

@onready var health = initial_health + floor(Game.get_elapsed_time() / 60.0) * health_per_minute
@onready var max_health = health

@onready var particles_scene = preload("res://scenes/particles/mob_kill.tscn")

var score_on_death: int = 500

var player

var self_destruct = 3.0

const ARROW_SPEED = 175


func _ready() -> void:
	
	#Make the arrow look at the player and go in his direction
	player = get_tree().get_first_node_in_group("player")
	look_at(player.position)
	velocity = position.direction_to(player.position) * ARROW_SPEED

func _physics_process(delta: float) -> void:
	
	#check if the arrow lifetime is more than 0
	self_destruct -= delta
	if self_destruct <= 0 :
		queue_free()
	
	#Move the Arrow
	move_and_collide(velocity * delta)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		health -= PlayerStats.damage

		var particles: GPUParticles2D = particles_scene.instantiate()
		particles.position = position

		add_child(particles)
		particles.emitting = true

		if health <= 0:
			#slow the player if the arrow hit
			PlayerStats.speed = min(PlayerStats.speed - PlayerStats.acceleration, PlayerStats.max_speed)
			queue_free()
