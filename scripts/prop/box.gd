extends Area2D

@onready var particles_scene = preload("res://scenes/particles/box_explosion.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		PlayerStats.speed = min(PlayerStats.speed - PlayerStats.acceleration, PlayerStats.maxSpeed)

		# spawn explosion particles in front of the player
		var particles: GPUParticles2D = particles_scene.instantiate()
		particles.position = position

		get_parent().add_child(particles)
		particles.emitting = true

		queue_free()
