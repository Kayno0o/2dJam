extends CharacterBody2D

const ROTATION_VELOCITY = .05
const VELOCITY_DECAY_PERCENT = 0.15  # The rate at which velocity decays

var speed = 15000


func _ready() -> void:
	return

func _physics_process(delta: float) -> void:
	# Rotate the player based on input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		rotate(rotation_direction * ROTATION_VELOCITY)

	# Accelerate the player forward
	velocity = Vector2(speed, 0).rotated(rotation - deg_to_rad(90)) * delta

	# Apply decay to reduce velocity over time
	var decay = speed * VELOCITY_DECAY_PERCENT * delta
	speed -= decay

	# Apply the movement
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		speed += 10000
		area.get_parent().queue_free()
