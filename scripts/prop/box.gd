extends Area2D

@onready var particles_scene = preload("res://scenes/particles/box_explosion.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D && body.is_in_group("player"):
		var player: CharacterBody2D = body
		PlayerStats.speed = min(PlayerStats.speed - PlayerStats.acceleration, PlayerStats.maxSpeed)

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
