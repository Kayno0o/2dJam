extends Area2D

@export var particles: GPUParticles2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		PlayerStats.speed = min(PlayerStats.speed - PlayerStats.acceleration, PlayerStats.max_speed)

		# spawn explosion
		particles.emitting = true

		queue_free()
