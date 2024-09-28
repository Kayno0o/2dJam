extends Area2D

signal destroyed

@export var deceleration_mult = 0.75

@onready var particles_scene = Game.resource_preloader.get_resource("particles-box_explosion")
@onready var break_sound = $BreakSound

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		PlayerStats.speed = min(PlayerStats.speed - PlayerStats.acceleration * deceleration_mult, PlayerStats.max_speed)

		# spawn explosion particles in front of the player
		var particles: GPUParticles2D = particles_scene.instantiate()
		particles.position = position

		get_parent().add_child(particles)
		particles.emitting = true

		break_sound.play()
		break_sound.process_mode = ProcessMode.PROCESS_MODE_ALWAYS

		destroyed.emit()

		visible = false
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

		await break_sound.finished

		queue_free()
