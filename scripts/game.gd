extends Node2D

@export var tilemap: TileMapLayer

const SPAWNING_RANGE = 800

var enemy = preload("res://scenes/entity/Curieux.tscn")
var player
var worldSizeInPixels: Vector2i

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	worldSizeInPixels = mapRect.size * tileSize

func _process(_delta: float) -> void:
	pass

func _draw() -> void:
	pass

func _on_timer_timeout():
	# Create a new enemy
	var newEnemy = enemy.instantiate()

	# Get a random position for the new enemy
	var randX = randi_range(0, worldSizeInPixels.x)
	var randY = randi_range(0, worldSizeInPixels.y)

	# Give him a position
	newEnemy.position = Vector2(randX, randY)

	# Spawn the enemy
	add_child(newEnemy)
