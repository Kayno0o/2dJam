extends Area2D

signal destroyed

@export var deceleration_mult = 0.75

@onready var particles_scene = Game.resource_preloader.get_resource("particles-box_explosion")
@onready var break_sound: AudioStreamPlayer = $BreakSound

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		PlayerStats.accelerate(-deceleration_mult)
		call_deferred("_deferred_disable_processing")

func _deferred_disable_processing():
	# spawn explosion particles in front of the player
	var particles: GPUParticles2D = particles_scene.instantiate()
	particles.position = position

	get_parent().add_child(particles)
	particles.emitting = true

	destroyed.emit()

	# play sound and kill self
	break_sound.play()

	visible = false
	set_physics_process(false)
	set_process(false)

	await break_sound.finished

	queue_free()
