extends CharacterBody2D

var PLAYER_GROUP
var PLAYER
var SPEED = 5000
var MAX_DISTANCE = 250
var MIN_DISTANCE = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Get all nodes that are attributed to the player group
	PLAYER_GROUP = get_tree().get_nodes_in_group("player")
	
	#Get the player ID
	PLAYER = PLAYER_GROUP[0]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	#Make the ennemie goal position to the player if far enough
	if position.distance_to(PLAYER.position) > MAX_DISTANCE :
		velocity = position.direction_to(PLAYER.position) * delta * SPEED
	
	#Make the ennemie goal position away from the player if too close
	elif position.distance_to(PLAYER.position) < MIN_DISTANCE :
		velocity = - position.direction_to(PLAYER.position) * delta * SPEED
	
	else :
		velocity = Vector2(0, 0)
	#Move the ennemie
	move_and_slide()
	pass
