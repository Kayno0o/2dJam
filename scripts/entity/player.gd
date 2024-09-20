extends CharacterBody2D

var speed = 15_000
var maxSpeed = 150_000

var acceleration = 10_000

var rotationVelocity = .05
var velocityPercent = 0.10

func _ready() -> void:
	return

func _physics_process(delta: float) -> void:
	# Rotate the player based on input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		rotate(rotation_direction * rotationVelocity)

	# Accelerate the player forward
	velocity = Vector2(speed, 0).rotated(rotation - deg_to_rad(90)) * delta

	# Apply decay to reduce velocity over time
	var decay = speed * velocityPercent * delta
	speed -= decay

	# Apply the movement
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		speed = min(speed + acceleration, maxSpeed)
		area.get_parent().HEALTH -= 1
