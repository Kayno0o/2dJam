extends Camera2D

# Smoothing duration in seconds
const SMOOTHING_DURATION: = 2

# The node to follow
var target: Node2D = null

# Current position of the camera
var current_position: Vector2

# Position the camera is moving towards
var destination_position: Vector2

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	current_position = target.position

func _process(delta: float) -> void:
	destination_position = target.position
	current_position += Vector2(destination_position.x - current_position.x, destination_position.y - current_position.y) / SMOOTHING_DURATION * delta
	
	position = current_position.round()
	force_update_scroll()
