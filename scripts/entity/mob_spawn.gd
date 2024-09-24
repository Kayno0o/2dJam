extends Timer

@export var player: CharacterBody2D

var enemy = preload("res://scenes/entity/Curieux.tscn")

func _ready():
	wait_time = .8
	start()

func _on_timeout() -> void:
	# Create a new enemy
	var newEnemy = enemy.instantiate()

	# Get a random position for the new enemy
	var randX = randi_range(0, Globals.worldSize.x)
	var randY = randi_range(0, Globals.worldSize.y)

	# Give him a position
	newEnemy.position = Vector2(randX, randY)

	# Spawn the enemy
	add_child(newEnemy)
