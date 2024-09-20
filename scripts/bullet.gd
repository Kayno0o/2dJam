extends CharacterBody2D


const ROTATION_VELOCITY = .05
var speedOverTime = 15000
const DAMPING = 0.15  # The rate at which velocity decays


func _ready() -> void:
	return

func _physics_process(delta: float) -> void:
	# Rotate the player based on input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		rotate(rotation_direction * ROTATION_VELOCITY)
	
	# Accelerate the player forward
	velocity = Vector2(speedOverTime, 0).rotated(rotation - deg_to_rad(90)) * delta
	
	# Apply damping to reduce velocity over time
	var decay = speedOverTime * DAMPING * delta
	speedOverTime -= decay
	
	# Apply the movement
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		speedOverTime += 10000
		area.queue_free()
	print_debug(area)
	pass # Replace with function body.
