extends Node2D

const SPAWNING_RANGE = 800

var enemy = preload("res://scenes/entity/Enemy.tscn")
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	pass

func _draw() -> void:
	pass

func _on_timer_timeout():
	# Create a new enemy
	var newEnemy = enemy.instantiate()

	# Get a random position for the new enemy
	var randX = randi_range(-SPAWNING_RANGE, SPAWNING_RANGE)
	var randY = randi_range(-SPAWNING_RANGE, SPAWNING_RANGE)

	# Give him a position
	newEnemy.position = Vector2(player.position.x + randX, player.position.y + randY)

	# Spawn the enemy
	add_child(newEnemy)
	pass # Replace with function body.
