extends CharacterBody2D

var player
var HEALTH = 1
const SPEED = 5000
const MAX_DISTANCE = 250
const MIN_DISTANCE = 200


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if HEALTH < 1 :
		queue_free()
	pass

func _physics_process(delta: float) -> void:
	# Make the enemy goal position to the player if far enough
	if position.distance_to(player.position) > MAX_DISTANCE :
		velocity = position.direction_to(player.position) * delta * SPEED

	# Make the enemy goal position away from the player if too close
	elif position.distance_to(player.position) < MIN_DISTANCE :
		velocity = - position.direction_to(player.position) * delta * SPEED

	else :
		velocity = Vector2(0, 0)

	# Move the ennemy
	move_and_slide()
