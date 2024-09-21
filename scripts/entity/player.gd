extends CharacterBody2D

var levelUpScene = preload("res://scenes/menu/ItemShop.tscn")

var actualLevel = 0
var actualXp = 0
var levelUpXp = 10

var instance

func _ready() -> void:
	return

func _input(event):
	#pauses when pressing P
	if event is InputEventKey :
		if event.keycode == 80 && event.is_pressed() == true:
			get_tree().paused = true

func _physics_process(delta: float) -> void:
	
	if actualXp >= levelUpXp :
		_level_up()
	
	# Rotate the player based on input
	var rotation_direction := Input.get_axis("ui_left", "ui_right")
	if rotation_direction:
		rotate(rotation_direction * PlayerStats.rotationVelocity)

	# Accelerate the player forward
	velocity = Vector2(PlayerStats.speed, 0).rotated(rotation - deg_to_rad(90)) * delta

	# Apply decay to reduce velocity over time
	var decay = PlayerStats.speed * PlayerStats.velocityPercent * delta
	PlayerStats.speed -= decay

	# Apply the movement
	move_and_slide()

func _level_up() :
	print("LEVEL UP")
	PlayerStats.playerPos = position
	instance = levelUpScene.instantiate()
	get_parent().add_child(instance)
	print(PlayerStats.damage)
	#Leveling up
	actualLevel += 1
	
	#Getting excess xp to the next level and reseting the xp
	actualXp -= levelUpXp
	
	#Make more Xp necessary to level up
	levelUpXp = levelUpXp + levelUpXp * 0.1
	
func _print_lvlup_screen() :
	
	pass
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		PlayerStats.speed = min(PlayerStats.speed + PlayerStats.acceleration, PlayerStats.maxSpeed)
		actualXp += area.get_parent().xpGain
		print(actualXp)
		area.get_parent().HEALTH -= PlayerStats.damage
