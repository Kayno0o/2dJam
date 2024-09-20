extends Node2D

var ENNEMIE = preload("res://scenes/Enemy.tscn")
var PLAYER_GROUP
var PLAYER
var SPAWNING_RANGE = 800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
		#Get all nodes that are attributed to the player group
	PLAYER_GROUP = get_tree().get_nodes_in_group("player")
	
	#Get the player ID
	PLAYER = PLAYER_GROUP[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _draw() -> void:
	pass


func _on_timer_timeout():
	
	# Create a new ennemie
	var Spawnling = ENNEMIE.instantiate()
	
	#Give him a position
	Spawnling.position = Vector2(PLAYER.position.x + randi_range(SPAWNING_RANGE, -SPAWNING_RANGE), PLAYER.position.y + randi_range(SPAWNING_RANGE, -SPAWNING_RANGE))
	
	#Spawn the ennemie
	add_child(Spawnling)
	pass # Replace with function body.
