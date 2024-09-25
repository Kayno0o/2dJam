extends CharacterBody2D

var particles_scene = preload("res://scenes/particles/mob_kill.tscn")

var player
var HEALTH = 1
const SPEED = 5000
const MAX_DISTANCE = 250
const MIN_DISTANCE = 200

const xpGain = 1


var moveToward = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if HEALTH < 1:
		print("argh")
		#Globals.ennemy_death.emit()
		queue_free()
	pass

func _physics_process(delta: float) -> void:
	# Make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > MAX_DISTANCE:
		moveToward = true
	# Make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < MIN_DISTANCE:
		moveToward = false

	if moveToward:
		velocity = position.direction_to(player.position) * delta * SPEED
	else:
		velocity = -position.direction_to(player.position) * delta * SPEED

	# Move the ennemy
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Area2D && area.get_parent().is_in_group("player"):
		# spawn explosion particles in front of the player
		var particles: GPUParticles2D = particles_scene.instantiate()
		player.add_child(particles)

		var normalized_velocity = player.velocity.normalized()
		
		var particleMaterial: ParticleProcessMaterial = particles.process_material
		if particleMaterial is ParticleProcessMaterial:
			# offset particles spawn
			particleMaterial.emission_shape_offset = Vector3(abs(normalized_velocity.x) * 32, 0, 0)

		particles.emitting = true

		queue_free()
